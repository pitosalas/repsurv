require 'spec_helper'

describe Program do
  let(:p11) { Program.find(11)}
  let(:p12) { Program.find(12)}
  let(:u11) { User.find(11)}
  let(:u12) { User.find(12)}
  let(:u21) { User.find(21)}

  
  it "knows who owns it" do
    p11.owned_by?(u11).should == true
    p11.owned_by?(u12).should == false
  end
  
  it "knows who can see it" do
    p11.visible_to?(u21).should == true
    p11.visible_to?(u12).should == false
  end
  it "knows who can admin it"
end
