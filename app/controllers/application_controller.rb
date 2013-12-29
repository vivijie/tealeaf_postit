class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def logged_in?
    # return a boolean
  	!!current_user  	
  end

  def require_user
  	if !logged_in?
  		flash[:error] = "Must logged_in"
  		redirect_to root_path
	  end  	
  end

  def require_admin
    access_message unless logged_in? and current_user.admin?
  end

  def access_message
    flash[:error] = "You can not do it."
    redirect_to root_path
  end

end
