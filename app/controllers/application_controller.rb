class ApplicationController < ActionController::Base

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authorize
      if current_user.nil?
        flash[:warning] = "Must be logged in!"
        redirect_to login_path
      end
    end

    def log_in(user)
      session[:user_id] = user.id
    end

    helper_method :current_user
end
