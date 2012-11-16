require 'spec_helper'

describe Value do
  it "prepares for a survey" do
    prog = Program.find(1)
    part = Participant.find(1)
    r = Round.where(open: true)
    r.size.should == 1
    round = r[0]
    vees = Value.find_or_create_round(prog, part, round)
    vees.size.should == 3
    vees[0].new_record?.should eq false
    vees[0].participant_id.should eq 1
    vees[0].class.should eq Value
    vees = Value.find_or_create_round(prog, part, round)
  end

  context "Value.param_parses" do
    it {Value.param_parse("Q12").should == 12}
    it {Value.param_parse("Q1").should == 1}
    it {Value.param_parse("RQ12").should be_nil }
  end

  context "Value.lookup" do
    it {Value.lookup(20,20,20,20).should be_nil }
    it { Value.lookup(1,1,1,1).value.should eq "1"}
  end
end
 