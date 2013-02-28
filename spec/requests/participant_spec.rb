require 'spec_helper'

describe "logged in" do
  before (:each) do
    u = create(:user, name: "sir abc", email: "abc@gmail.com", password: "abcdef", roles: "moderator")
    prog = create(:program, name: "program", moderator: u)
    create(:participant, hidden: false, program: prog, user: u)
    visit programs_url
    click_link "Login"
    fill_in "user_email", with: "abc@gmail.com"
    fill_in "user_password", with: "abcdef"
    click_button "Sign in"
  end

  describe "program list" do
    it { page.should have_content "program" }
    it "has clickable program" do 
        click_link "program"
        click_link "Participants"
        page.should have_content "sir abc"
    end
  end
end

 