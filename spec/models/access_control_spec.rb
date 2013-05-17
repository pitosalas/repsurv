require 'spec_helper'

describe "in file: #{__FILE__}" do
  fixtures :programs
  fixtures :users
  fixtures :participants
  let(:p11) { programs(:class_11)}
  let(:p12) { programs(:class_12)}
  let(:u11) { users(:teacher11)}
  let(:u12) { users(:teacher12)}
  let(:u21) { users(:student21)}

  context "program access control" do
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
end
