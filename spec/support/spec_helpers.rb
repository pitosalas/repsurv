require 'database_cleaner'

module SpecHelpers
	def setup_test_data
		@u1 = FactoryGirl.create(:user)
		@u2 = FactoryGirl.create(:user)
		@p1 = FactoryGirl.create(:program, moderator: @u1)
		@p2 = FactoryGirl.create(:program, moderator: @u2)
		@p3 = FactoryGirl.create(:program, moderator: @u1)
		@part1 = FactoryGirl.create(:participant, user: @u1, program: @p1)
		@part2 = FactoryGirl.create(:participant, user: @u2, program: @p2)
		@part3 = FactoryGirl.create(:participant, user: @u2, program: @p3)
	end

	def clean_database
		DatabaseCleaner.clean
	end
end
