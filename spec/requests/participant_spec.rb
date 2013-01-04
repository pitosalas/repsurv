require 'spec_helper'
describe "Particpants" do
  before (:each) do
    visit programs_url
    click_link "program1"
    click_link "Participants"
    click_link "I M Dummy"
  end

  it "displays a participant" do
    puts page.class
    puts page.inspect
    page.should have_content "User: I M Dummy"
  end
end

 