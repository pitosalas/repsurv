require 'spec_helper'

describe TodolistController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index, user_id: 21
      response.should be_success
    end
  end

end
