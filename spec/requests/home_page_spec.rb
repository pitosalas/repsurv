require 'spec_helper'
describe "Non-logged in home page" do
  it "displays home page at root" do
    visit root_url
    page.should have_content "Repeat Survey"
  end
end
describe "Logged in home page" do
  before(:each) do
    create(:user, name: "sir abc", email: "abc@gmail.com", password: "abcdef", roles: "moderator")
    visit root_url
    click_link "Login"
    fill_in "user_email", with: "abc@gmail.com"
    fill_in "user_password", with: "abcdef"
    click_button "Sign in"
  end
  it "returns to root when clicking on home link" do
    visit programs_url
    click_link "Create a new Program"
    click_link "Repeat Survey"
    page.should have_content "Welcome"
  end

  it "returns to root when clicking on App Survey Logo link" do
    visit programs_url
    click_link "Create a new Program"
    page.should have_content "Repeat"
    click_link "Repeat"
    page.should have_content "Welcome"
  end
end
