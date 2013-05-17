require 'spec_helper'

describe Participant do
	before (:each) do
		create(:participant)
	end
  it { Participant.find(1).guid.should_not be_blank }
end

