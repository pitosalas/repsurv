require 'spec_helper'

describe SettingsController do

  describe "GET 'name:string'" do
    it "returns http success" do
      get 'name:string'
      response.should be_success
    end
  end

  describe "GET 'program_id:integer'" do
    it "returns http success" do
      get 'program_id:integer'
      response.should be_success
    end
  end

end
