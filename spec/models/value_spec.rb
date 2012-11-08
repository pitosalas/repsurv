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
    vees[0].new_record?.should be false
    vees[0].participant_id.should == 1
    vees[0].class.should == Value
  end
end
