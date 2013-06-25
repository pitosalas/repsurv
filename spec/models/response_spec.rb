require 'spec_helper'

describe "From file: #{__FILE__}" do
  fixtures :programs
  fixtures :users
  fixtures :participants
  fixtures :rounds
  fixtures :questions
  fixtures :responses

  it "prepares for a survey" do
    prog = Program.find(1)
    part = Participant.find(1)
    r = Round.where(open_status: true)
    r.size.should == 1
    round = r[0]
    vees = Response.find_or_create_round(prog, part, round)
    vees.size.should == 3
    vees[0].new_record?.should eq false
    vees[0].participant_id.should eq 1
    vees[0].class.should eq Response
    vees = Response.find_or_create_round(prog, part, round)
  end

  context "Value.param_parses" do
    it {Response.param_parse("Q12").should == 12}
    it {Response.param_parse("Q1").should == 1}
    it {Response.param_parse("RQ12").should be_nil }
  end

  context "Response#lookup" do
    it {Response.lookup(20,20,20,20).should be_nil }
    it {Response.lookup(1,1,1,1).value.should eq "1"}
  end
end
 