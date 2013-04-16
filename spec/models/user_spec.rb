require 'spec_helper'
require 'pry'

describe User do
	context "Programs with overlapping participations" do
		before (:each) do
			@pr1 = create(:program, name: "prog1")
			@pr2 = create(:program, name: "prog2")

			@us1 = create(:user, name: "User1")
			@us2 = create(:user, name: "User2")
			@us3 = create(:user, name: "User3")

			@part1 = create(:participant, user: @us1)
			@part2 = create(:participant, user: @us2)
			@part3 = create(:participant, user: @us3)

			@pr1.participants << @part1
			@pr1.participants << @part2
			@pr2.participants << @part3
		end

		it "user visible to himself" do
			(@us1.visible_to? @us1).should be_true
		end

		it "two users participate in the same program they should be visible to each other" do
			(@us1.visible_to? @us2).should be_true
		end

		it "two users dont share a program they should not be visible to each other" do
			(@us1.visible_to? @us3).should_not be_true
		end
	end

end
