require 'spec_helper'
describe "Particpants" do
  it "displays home page at root" do
    visit root_url
    page.should have_content "Repeat Survey"
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