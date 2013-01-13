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

  context "with factory girl" do
    let(:goodguy) { create(:user, name: "Good guy") }
    let(:badguy ) { create(:user, name: "Baddie") }
    let(:p)       { create(:program, name: "A Program", moderator: goodguy ) }

    it "can be admined by it's owned" do
      p.managed_by?(goodguy).should == true
    end
    it "cannot be adminned by someone else" do
      p.managed_by?(badguy).should == false
    end
  end
end
