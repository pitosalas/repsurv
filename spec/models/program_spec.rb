require 'spec_helper'
include SpecHelpers

describe Program do
  it { Program.find(1).current_round.id.should eq 4 }
  it { Program.find(2).current_round.should eq nil }
end

describe "FactoryGirl program" do
  it {FactoryGirl.create(:program).should be_valid }
end

describe Program do
	before do 
		clean_database
		setup_test_data
	end

	describe "when listing subsets" do
		it "lists only programs coordinated by a certain user" do
			Program.moderated_by(@u1).count.should == 2
			Program.moderated_by(@u2).count.should == 1
		end

		it "lists only programs participated by a certain user" do
			Program.participated_in_by(@u1).count.should == 1
			Program.participated_in_by(@u2).count.should == 2
		end
	end
end
