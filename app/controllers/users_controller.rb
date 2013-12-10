class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  	  flash[:notice] = "User created!"	
  	  redirect_to users_path
  	else
  	  render 'users/new'
  	end
  end

  def index
  	@users = User.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	  flash[:notice] = "User info updated!"
  	  redirect_to users_path
  	else
  	  render edit_user_path(params[:id])
  	end

  end


  private
  def user_params
  	params.require(:user).permit(:username, :password, :password_confirmation)
  end
end