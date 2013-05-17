require 'spec_helper'

describe TodolistController do
  fixtures :programs
  fixtures :users
  fixtures :participants
  fixtures :rounds
  fixtures :questions
  fixtures :responses

  describe "GET 'index'" do
    it "returns http success" do
      get :index, user_id: 1
      response.should be_success
    end
  end

end
