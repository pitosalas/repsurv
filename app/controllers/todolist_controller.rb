class TodolistController < ApplicationController
  def index
  	user = User.find(params[:user_id])
  	@todolist = ToDoList.new(user)
  	@todolist.create_todolist
  	render @todolist.view_path
  end
end
