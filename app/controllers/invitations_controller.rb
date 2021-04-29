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
    # for manual entry of a url, e.g. "/invitations/10", redirect to root
    respond_to do |format|
      flash[:info] = "You have been redirected. Invitations managed on event pages."
      format.html { redirect_to root_url }
    end
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
end
