class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      session[:userid_roles] = user.roles.map { |role| role.name }
      if session[:userid_roles].include?("administrator")
        redirect_to admin_url
      else
        redirect_to store_index_url
      end
    else
      redirect_to login_url, alert: "invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out"
  end

end
