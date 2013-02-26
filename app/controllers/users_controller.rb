class UsersController < ApplicationController
  load_and_authorize_resource


  def index
      @users = User.paginate(page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    if @user.save
      redirect_to action: "index", notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
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