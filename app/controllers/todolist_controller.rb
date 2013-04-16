class TodolistController < ApplicationController
  def index
  	user = User.find(params[:user_id])
  	@todolist = ToDoList.new(user.name)
  end
end
