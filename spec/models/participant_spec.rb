require 'spec_helper'

describe Participant do
  it { Participant.find(1).guid.should_not be_blank }
end

