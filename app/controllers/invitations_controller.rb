class InvitationsController < ApplicationController
  before_action :authorize, only: [:create, :update, :destroy, :show]

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
  end

  # for "Attend" or "Leave Event"
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

  # for "uninviting"
  def destroy
    @invitation = Invitation.find(params[:id])
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

    def 
end
