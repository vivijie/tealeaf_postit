class SessionsController < ApplicationController

  def new
  	
  end

  def create
  	user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
  	  if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        # send pin to twilio, sms to user's phone
        redirect_to pin_path
      else
        normal_login(user)
      end
  	else
  	  flash[:error] = "There's something wrong with your username or password."
  	  redirect_to login_path
  	end
  end

  def destroy
  	session[:user_id] = nil
  	flash[:notice] = "You've logged out!"
  	redirect_to root_path
  end

  def pin
    access_message if session[:two_factor].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        # add pin session, that only two_factor user can visit pin_path
        session[:two_factor] = nil
        # remove pin
        user.remove_pin!
        # normal login success
        normal_login(user)
      else
        flash[:error] = "Sorry, wrong pin number"
        redirect_to pin_path
      end  
    end
  end

  def normal_login(user)
    session[:user_id] = user.id
    flash[:notice] = "You've logged in!"
    redirect_to root_path
  end


end