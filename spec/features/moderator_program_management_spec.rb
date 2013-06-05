require 'spec_helper'

describe "moderator"  do
  before(:each) do
    create(:moderator_user, email: "abc@gmail.com", name: "Wow Man")
    visit root_url
    click_on "login"
    fill_in "Email", with: "abc@gmail.com"
    fill_in "Password", with: "aaaaaa"
    click_button "Sign in"

  end

  it "can create a new valid program" do
    page.should have_content "Moderator Console"
    click_on "new_program_button"
    fill_in "program_name", with: "Wow Program"
    click_on "create_program"
    within "#program_name" do
    	page.should have_content "Wow Program"
    end
    tp = Program.where(name: "Wow Program").first
    expect(tp.name).to eq "Wow Program"
    expect(tp.moderator.name).to eq "Wow Man"
  end
end
