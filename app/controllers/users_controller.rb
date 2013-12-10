class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

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

  def edit; end

  def update
  	if @user.update(user_params)
  	  flash[:notice] = "User info updated!"
  	  redirect_to users_path
  	else
  	  render edit_user_path(params[:id])
  	end

  end

  def show
  	
  end


  private
  def user_params
  	params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def set_user
	@user = User.find(params[:id])  	
  end
end