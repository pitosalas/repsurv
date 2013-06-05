require 'spec_helper'

describe "moderator console"  do
  before(:each) do
    create(:moderator_user, email: "abc@gmail.com")
    visit root_url
    click_on "login"
    fill_in "Email", with: "abc@gmail.com"
    fill_in "Password", with: "aaaaaa"
    click_button "Sign in"

  end

  it "gets to the moderator console" do
    page.should have_content "Moderator Console"
  end
end
