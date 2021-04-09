class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    user = User.find(current_user.id)
    @invitation = user.sent_invitations.build(invitation_params)
    if @invitation.save
      flash[:success] = "Invitation sent!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update(attending: params[:attending])
      flash[:success] = "rsvp updated"
      redirect_to @invitation
    else
      render 'edit'
    end
  end

  private
    def invitation_params
      params.require(:invitation).permit(:invitee, :event, :attending)
    end
end
