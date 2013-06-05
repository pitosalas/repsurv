require 'spec_helper'

describe "admin console"  do
  before(:each) do
    create(:admin_user, email: "abc@gmail.com")
    visit root_url
    click_on "login"
    fill_in "Email", with: "abc@gmail.com"
    fill_in "Password", with: "aaaaaa"
    click_button "Sign in"
  end

  it "gets to the admin console" do
    page.should have_content "Admin Console"
  end
end
