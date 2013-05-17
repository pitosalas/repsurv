require 'spec_helper'

describe "in file: #{__FILE__}" do

	context "In Programs with overlapping participations" do
		before (:each) do
			@us1 = create(:user, name: "User1", roles: [ :moderator] )
			@us2 = create(:user, name: "User2")
			@us3 = create(:user, name: "User3", roles: [ :participant ])
			@us4 = create(:user, name: "User4 Admin", roles: [ :admin ])

			@pr1 = create(:program, name: "prog1", moderator: @us1)
			@pr2 = create(:program, name: "prog2", moderator: @us4)

			@part1 = create(:participant, user: @us1)
			@part2 = create(:participant, user: @us2)
			@part3 = create(:participant, user: @us3)

			@pr1.participants << @part1
			@pr1.participants << @part2
			@pr2.participants << @part3
		end

		context "a user will" do 

			it "be visible to himself" do
				(@us1.visible_to? @us1).should be_true
			end

			it "be visible to another user participating in the same program" do 
				(@us1.visible_to? @us2).should be_true
			end

			it "be invisible to another user that doesnt share a program" do
				(@us1.visible_to? @us3).should_not be_true
			end

			it "correctly figure out its participations, case 1" do
				participation = @us1.participant_in @pr1
				participation.should == @part1
			end

			it "correctly figure it's participations, case 2" do
				participation = @us2.participant_in @pr1
				participation.should == @part2
			end

			it "correctly figure it's participations, case 3" do
				participation = @us3.participant_in @pr1
				participation.should be_nil
			end

			it "the relevant programs (admin user case)" do
				@us4.relevant_programs.length.should be 2
			end

			it "the relevant programs (moderator user case)" do
				progs = @us1.relevant_programs
				progs.length.should be 1
				progs.first.name.should == "prog1"
			end

			it "the relevant programs (participant user case)" do
				progs = @us3.relevant_programs
				progs.length.should be 1
				progs.first.name.should == "prog2"
			end
		end
	end

end
