require 'database_cleaner'

module SpecTestDataFactories
	def setup_test_data_1
		@u1 = FactoryGirl.create(:user)
		@u2 = FactoryGirl.create(:user)
		@p1 = FactoryGirl.create(:program, moderator: @u1)
		@p2 = FactoryGirl.create(:program, moderator: @u2)
		@p3 = FactoryGirl.create(:program, moderator: @u1)
		@part1 = FactoryGirl.create(:participant, user: @u1, program: @p1)
		@part2 = FactoryGirl.create(:participant, user: @u2, program: @p2)
		@part3 = FactoryGirl.create(:participant, user: @u2, program: @p3)
	end

	def setup_test_data_2
		users = create_users(3)
		program = create(:program, moderator: users[0])
		participants = create_participants(program, users)
		rounds = create_rounds(program, 3)
		questions = create_questions(program, 5)
		{ program: program, users: users, participants: participants, rounds: rounds, questions: questions}
	end

	def create_programs count
    Array.new(count) { create(:program ) }
  end

	def create_users count
    Array.new(count) { create(:user ) }
  end

  def create_participants prog, users
  	users.map { |usr| create(:participant, program: prog, user: usr) }
  end

  def create_rounds prog, count
  	Array.new(count) { create(:round, program: prog, open_status: false)}
  end

  def create_questions prog, count
 		Array.new(count) { create(:question, program: prog)}
 	end

	def clean_database
		DatabaseCleaner.clean
	end
end
