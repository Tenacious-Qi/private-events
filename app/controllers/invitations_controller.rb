class InvitationsController < ApplicationController

  before_action :authorize, only: [:create, :update, :destroy]
  before_action :correct_user, only: [:create, :update, :new]

  def new
    @invitation = Invitation.new
  end

  def create
    host = User.find(current_user.id)
    @invitation = host.sent_invitations.build(invitation_params)
    @event = @invitation.event
    if @invitation.save
      respond_to do |format|
        format.html { redirect_to @event }
        format.js
      end
    end
  end

  def show
    @invitation = Event.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    @event = @invitation.event
    @rsvp = @event.invitations.find_by(event_id: @event.id, invitee_id: current_user.id)
    @rsvp.update_attribute(:attending, params[:attending])
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
      format.json { render :partial => "invitations/show" }
    end
  end

  def destroy
    @invitation = Invitation.find_by(invitee: params[:invitee_id], event_id: params[:id])
    @event = @invitation.event
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
      end
  end

  private
    def invitation_params
      params.require(:invitation).permit(:invitee_id, :event_id, :host_id, :attending)
    end
end
