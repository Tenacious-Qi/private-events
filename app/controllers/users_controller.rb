class UsersController < ApplicationController
  before_action :authorize, only: [:show]
  helper_method :previously_attended_events
  helper_method :find_invitation

  def new
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:info] = "Account successfully created"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def find_invitation(event)
      event.invitations.find_by(invitee_id: @user.id)
    end

    def previously_attended_events
      @user.invited_events.past.includes(:invitations).where("attending = 'yes'")      
    end

end
