require 'spec_helper'

describe "Smoke Test" do
  before(:each) do
	  create(:user, name: "sir abc", email: "abc@gmail.com", password: "abcdef", roles: "moderator")
	  visit root_url
	  click_link "Login"
	  fill_in "user_email", with: "abc@gmail.com"
	  fill_in "user_password", with: "abcdef"
	  click_button "Sign in"
  end

  it "can create a program" do
	  visit programs_url
	  click_link "Create a new Program"
	  click_button "Create new program"
  end
end
