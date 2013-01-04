require 'spec_helper'

RSpec.configure do |c|
  c.backtrace_clean_patterns << /gems\//
  puts c.backtrace_clean_patterns
end


describe Participant do
  it { Participant.find(1).guid.should_not be_blank }
end

