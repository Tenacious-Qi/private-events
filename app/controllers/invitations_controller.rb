class InvitationsController < ApplicationController
  before_action :authorize, only: [:create, :update]
  before_action :correct_user, only: [:create, :update, :new]

  def new
    @invitation = Invitation.new
  end

  def create
    host = User.find(current_user.id)
    @invitation = host.sent_invitations.build(invitation_params)
    if @invitation.save
      flash[:success] = "Invitation sent!"
      redirect_to @invitation.event
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
      params.require(:invitation).permit(:invitee_id, :event_id, :host_id, :attending)
    end
end
