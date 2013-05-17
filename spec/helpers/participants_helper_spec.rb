require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ParticipantsHelper. For example:
#
# describe ParticipantsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ParticipantsHelper do
	fixtures :programs
	fixtures :participants
  it "generates correct survey link when there are no rounds" do

# I know that in the fixtures, Program two has no rounds, so no active survey
    prog = Program.find(2)
    part = Participant.find(1)
    current_survey_link(prog, part).should == "[no active survey right now]"
  end
end
