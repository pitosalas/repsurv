class ToDoList
	include Enumerable

	ProgRowInfo = Value.new(:name, 
													:id,
													:opened,
													:closed,
													:n_questions,
													:n_participants,
													:n_rounds,
													:moderator)
	RoundRowInfo = Value.new(:name, 
													:id, 
													:opened,
													:closed,
													:n_open_questions,
													:n_completed,
													:n_have_started,
													:n_not_completed,
													:n_not_yet_started,
													:days_to_go,
													:survey_url)

	def initialize user
		@to_do_list = []
		@user = user
	end

	def create_todolist
		progs = @user.relevant_programs
		@to_do_list = progs.map { |prog| create_todo_list_row(prog) } unless progs.nil? || progs.empty?
	end

	def create_todo_list_row prog
		total_participants = prog.participants.count
		total_questions = prog.questions.count
		round = prog.current_round
		part = @user.participant_in prog

		pri = ProgRowInfo.with(
			name: prog.name,
			id: prog.id,
			moderator: prog.moderator.name,
			opened: prog.opened,
			closed: prog.closed,
			n_rounds: prog.rounds.count,
			n_questions: total_questions,
			n_participants: total_participants)

		if !round.nil?
			n_resonses_by_participant = round.n_resonses_by_participant
			n_participants_who_have_completed = 
				n_resonses_by_participant.reduce(0) { |memo, obj| obj[1] == total_questions ? memo + 1 : memo }
			n_participants_who_have_started = n_resonses_by_participant.count			
			if !part.nil?
				n_responses_this_participant = n_resonses_by_participant[part.id] || 0
				n_open_questions_this_participant = total_questions - n_responses_this_participant
			end

			rri = RoundRowInfo.with(
				name: round.row_label,
				id: round.id,
				opened: round.opened,
				closed: round.closed,
				days_to_go: 0,
				n_open_questions: n_open_questions_this_participant,
				n_completed: n_participants_who_have_completed,
				n_have_started: n_participants_who_have_started,
				n_not_completed: total_participants -  n_participants_who_have_completed,
				n_not_yet_started: total_participants - n_participants_who_have_completed - n_participants_who_have_started,
				survey_url: "#")
		end
		[pri, rri]
	end

	
	def each &block
		# or @to_do_list.each(&block)
		@to_do_list.each { |member| block.call(member)}
	end

	def user_name
		@user.name
	end

	def view_path
		fail("ToDoList#view_path encountered user without a role") if @user.nil? || @user.roles == [] 
		@user.roles.first.to_s + "_index"
	end

end
