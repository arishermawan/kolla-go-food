class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session

  protected
    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: 'Please Login'
      end
    end
end
