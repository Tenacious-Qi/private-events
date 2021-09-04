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
      InvitationMailer.with(invitation: @invitation).invitation_email.deliver_later
      respond_to do |format|
        format.html { redirect_to @event }
        format.js
      end
    end
  end
  
  # for "Attend" or "Leave Event"
  def update
    @invitation = Invitation.find(params[:id])
    @event = @invitation.event
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @event }
        format.js
        format.json { render :partial => "invitations/show" }
      else
        flash[:warning] = "Failed to update invitation."
        redirect_to @event
      end
    end
  end

  # for "uninviting"
  def destroy
    @invitation = Invitation.find(params[:id])
    @event = @invitation.event
    InvitationMailer.with(invitation: @invitation).uninvite_email.deliver_later
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
