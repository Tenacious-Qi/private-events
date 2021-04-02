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
      redirect_to @user
    else
      flash[:warning] = 'Incorrect email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    render 'new'
  end
    
end
