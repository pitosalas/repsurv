require 'spec_helper'

describe Program do
  it { Program.find(1).current_round.id.should eq 4 }
  it { Program.find(2).current_round.should eq nil }
end

describe "FactoryGirl program" do
  it {FactoryGirl.create(:program).should be_valid }
end
