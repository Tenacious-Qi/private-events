class SessionsController < ApplicationController

  def new
    # prevent a logged in user from going to login_path
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      flash[:success] = 'Logged in!'
      redirect_to root_url
    else
      flash[:warning] = 'Incorrect email or password'
      render 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    flash[:info] = 'You have logged out.'
    # using render 'new' causes routing error after refreshing page
    # ( No Route matches GET "logout")
    redirect_to login_path
  end
    
end
