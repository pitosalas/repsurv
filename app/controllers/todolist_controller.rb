class TodolistController < ApplicationController

  def index
    puts "---> Signed In: #{current_user.inspect}"
  	user = User.find(params[:user_id])
  	@todolist = ToDoList.new(user)
  	@todolist.create_todolist
  	render @todolist.view_path
  end

  def not_signed_in
  	if user_signed_in?
      puts "---> Not Signed In: #{current_user.inspect}"
  		@todolist = ToDoList.new(current_user)
  		@todolist.create_todolist
  		render @todolist.view_path
  	else
  		render :not_signed_in
		end
  end
end
