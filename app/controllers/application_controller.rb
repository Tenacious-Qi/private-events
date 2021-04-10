class ApplicationController < ActionController::Base

  private
    def current_user
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    end

    def authorize
      if current_user.nil?
        flash[:warning] = "Must be logged in!"
        redirect_to login_path
      end
    end

    def correct_user
      if !current_user == @user
        flash[:warning] = "You can only update your own rsvp."
        redirect_to root_url
      end
    end
    
    def log_in(user)
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
    end

    helper_method :current_user
end
