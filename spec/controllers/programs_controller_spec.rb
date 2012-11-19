require 'spec_helper'

describe ProgramsController do
  it "visitis the home page" do
    get :index
  end
end
