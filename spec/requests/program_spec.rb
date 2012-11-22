require 'spec_helper'
describe "Program" do
  it "passes smoke test" do
    visit programs_url
    click_link "Create a new Program"
    click_button "Create new program"
  end
end
