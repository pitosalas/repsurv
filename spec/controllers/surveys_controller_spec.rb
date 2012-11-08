require 'spec_helper'

describe SurveysController do

  describe "GET 'survey'" do
    it "returns http success" do
      get 'survey'
      response.should be_success
    end
  end

end
