require 'spec_helper'

describe "Participant To Do List"  do
  before(:each) do
    create(:participant_user, email: "abc@gmail.com")
    visit root_url
    click_on "login"
    fill_in "Email", with: "abc@gmail.com"
    fill_in "Password", with: "aaaaaa"
    click_button "Sign in"

  end

  it "gets to the participant to do list" do
    page.should have_content "To Do List for a name"
  end
end
