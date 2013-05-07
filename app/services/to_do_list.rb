class ToDoList
	include Enumerable

	ToDoListRow = Value.new(:program_name, 
													:survey_url, 
													:round_name, 
													:round_identifier, 
													:open_questions,
													:total_participants,
													:completed_round,
													:not_completed_yet,
													:round_open,
													:round_close,
													:days_to_go)

	def initialize(user)
		@user = user
		generate_todolist
	end

	def user_name
		@user.name
	end

	def generate_todolist
		progs = @user.participating_programs
		@to_do_list = progs.map { |prog| build_todolist_row(prog) }
		@to_do_list.compact!
	end

	# return nil if analysis yields no todolist row. compact! above removes the nil.
	def build_todolist_row prog
		rounds = prog.open_rounds
		raise "more than one round open in ToDoList" if rounds.length > 1
		return nil if rounds.length == 0
		round = rounds[0]
		raise "mismatch program id in ToDoList#build_todolist_row" if round.program != prog

		part = @user.participant_in prog
		raise "ToDoList#build_todolist_row error" if part.nil?


		total_questions = prog.questions.count
		total_participants = prog.participants.count
		response_count_by_participant = round.response_count_by_participant
		responses = response_count_by_participant[part.id] || 0
		missing_responses = total_questions - responses
		participants_who_have_completed = 
			response_count_by_participant.reduce(0) { |memo, obj| obj[1] == total_questions ? memo + 1 : memo }


		return ToDoListRow.with(program_name: prog.name, 
														round_name: round.row_label,
														round_open: round.open_date,
														round_close: round.close_date,

														open_questions: missing_responses,
														round_identifier: round.id,
														total_participants: total_participants,
														completed_round: participants_who_have_completed,
														not_completed_yet: total_participants -  participants_who_have_completed,
														survey_url: "#")
	end


	def each &block
		# or @to_do_list.each(&block)
		@to_do_list.each { |member| block.call(member)}
	end

end
