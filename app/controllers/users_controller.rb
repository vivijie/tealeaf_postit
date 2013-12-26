class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def create

  	@user = User.new(user_params)
  	if @user.save
  	  flash[:notice] = "User created!"
      session[:user_id] = @user.id	
  	  redirect_to user_path(@user.id)
  	else
  	  render 'users/new'
  	end
  end

  def edit
  end

  def update
  	if @user.update(user_params)
  	  flash[:notice] = "User info updated!"
  	  redirect_to user_path(@user)
  	else
  	  render :edit
  	end

  end

  def show
#    binding.pry
  end


  private
  def user_params
  	params.require(:user).permit(:username, :password)
  end

  def set_user
	  @user = User.find_by slugs: params[:id] 	
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You are not allow to do it!!!"
      redirect_to root_path
    end
  end
end