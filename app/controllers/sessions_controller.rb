class SessionsController < ApplicationController
  def new
    @title = 'Sign in'
    if logged_in?
      redirect_to root_path, notice: 'You are already logged in !'
    end
  end

  # rubocop:disable MethodLength
  def create
    params_session = params[:session]
    username = params_session[:username]
    password = params_session[:password]
    remember_me = params_session[:remember_me]
    # collect user's ip address
    user_ip_address = UsersHelper.ip_address
    user = User.find_by(username: username) || User.find_by(email: username.downcase)
    if (user && user.published) && user.authenticate(password)
      log_in user
      remember_me == '1' ? remember(user) : forget(user)
      user.update(ip_address: user_ip_address)
      if user.user_type.name == 'customer'
        redirect_to root_url, notice: 'Logged in !'
      else
        redirect_to welcome_url, notice: 'Logged in !'
      end
    else
      redirect_to login_path, alert: 'Invalid data combination ! Please log in again'
    end
  end

  def destroy
    user = User.find_by(id: current_user.id)    
    log_out if logged_in?
    redirect_to login_path, notice: 'Logged out !'
  end
end
