class DatabaseConsistency
	def initialize
		@show_successes = false
		@attempt_repair = true
		@show_failures = false
		@info_messages = true
	end

	def verify_all
		ActiveRecord::Base.logger.level = 1
		Program.all.each { |p| verify_program(p)}
		nil
	end

	def verify_program prog
		puts "Program #{prog.name}"
		verify_participants prog
		verify_rounds prog
		verify_questions prog
		verify_response_duplicates prog
		verify_consistent_responses prog
		display_program_summary
	end

	def display_program_summary
		if @info_messages
			puts "  Counts: part: #{@parts_counts}, quest: #{@question_counts}, rounds: #{@round_counts}"
			puts "  Responses: #{@response_counts} [Max legal = #{@parts_counts * @question_counts * @round_counts}]"
		end
	end

	def verify_rounds prog
		rounds = prog.rounds
		@round_counts = rounds.size
		puts "  Rounds: #{rounds.map(&:id).join(', ')}" if @info_messages
	end

	def verify_questions prog
		questions = prog.questions
		@question_counts = questions.size
		puts "  Questions: #{questions.map(&:id).join(', ')}" if @info_messages
	end

	def verify_participants prog
		parts = prog.participants
		@parts_counts = parts.size
		puts "  participants: #{parts.map(&:id).join(', ')}" if @info_messages
		parts.each do |part|
			user = part.user
			chk_not_null user, "Participant #{part.id} - valid user"
		end
	end

	def verify_response_duplicates prog
		rounds = prog.rounds
		rounds.each do |round|
			questions = prog.questions
			questions.each do |quest|
				participants = prog.participants
				participants.each do |partic|
					responses = prog.responses
					resp = responses.where(participant_id: partic.id,
																question_id: quest.id,
																round_id: round.id)
					chk_array_size_le resp, 1, "Response for: p: #{partic.id} q: #{quest.id} r: #{round.id}"
					repair_duplicate_responses(resp) if @attempt_repair && resp.size > 1
				end
			end
		end
	end

	def verify_consistent_responses prog
		error_counter = 0
		success_counter = 0
		@response_counts = prog.responses.size
		prog.responses.each do 
			|resp|
				if (resp.question.program != prog || 
						resp.participant.program != prog ||
						resp.round.program != prog)
				puts "FAIL: Inconsistent response (#{resp.id})" if @show_failures
				puts "    p: #{resp.participant_id} q: #{resp.question_id} r: #{resp.round_id}" if @show_failures
				if @attempt_repair
					resp.delete
				end
				error_counter += 1
			else
				puts "OK: Consistent response (#{resp.id})" if @show_successes	
				success_counter += 1
			end
		end
		puts "  Responses: #{success_counter} consistent and #{error_counter} inconsistent"
	end

private

	def repair_duplicate_responses resp
		puts "Deleting duplicate responses: #{resp.size}"
		saver = resp.pop
		puts "   saving res: #{saver.id} [p: #{saver.participant_id} q: #{saver.question_id} r: #{saver.round_id}]"
		puts "   deleting #{resp.map(&:id).join(', ')}"
		resp.destroy_all
	end


	def chk_array_size_le arr, siz, msg
		puts "OK: #{msg}" if arr.size <= siz && @show_successes
		puts "FAIL: #{msg} (#{arr.size})" if arr.size > siz && @show_failures
	end

	def chk_not_null val, msg
		puts "#{msg}: OK" if ((!val.nil?) && @show_successes)
		puts "#{msg}:  unexpected nil" if val.nil? && @show_failures
	end

end
