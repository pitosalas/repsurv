require 'will_paginate/array'

class UsersController < ApplicationController
    before_filter :authenticate_user!


  def index
    unless current_user.nil? 
      @users = User.all.find_all { |user| user.visible_to? current_user }
      @users = @users.paginate(page: params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    authorize! :show, @user
  end

  # def new
  #   @user = User.new
  #   @user.roles = [ :participant ]
  # end

  # def create
  #   if @user.save
  #     redirect_to action: "index", notice: 'User was successfully created.'
  #   else
  #     render action: "new"
  #   end
  # end

  def edit
    @user = User.find(params[:id])
    authorize! :edit , @user
  end

  def update
    # if password is blank then we are not changing it.
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if @user.update_attributes(params[:user])
      redirect_to action: "index" , notice: 'User was successfully updated'
      return
    else
       render 'edit'
    end
  end

  def destroy
  end

end