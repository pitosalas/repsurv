require 'spec_helper'
describe "Particpants" do
  before (:each) do
    visit programs_url
    click_link "program1"
    click_link "Participants"
    click_link "Person 1"
  end

  it "displays a participant" do
    page.should have_field "participant[name]", with: "Person 1"
  end

  it "displays the unique survey link" do
    page.should have_link "Current survey form"
  end
end

describe "Participant List" do
  before :each do
    visit programs_url
    click_link "program1"
    click_link "Participants"
  end

  it "can createa a new participant" do
    click_link "Create a new Participant"
  end
end

 