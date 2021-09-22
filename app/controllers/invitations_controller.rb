class InvitationsController < ApplicationController
  before_action :authorize, only: %i[create update destroy show]

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

  def create
    # for flash message: to state how many invitations were sent
    @invitations = []
    @event = Event.find(invitation_params[:event_id].to_i)
    invitation_params[:recipient_ids].each do |id|
      host = User.find(current_user.id)
      invitation = Invitation.new(invitee_id: id,
                                   event_id: @event.id,
                                   host_id: host.id)
      @event = invitation.event
      next unless invitation.save

      @invitations << invitation
      InvitationMailer.with(invitation: invitation).invitation_email.deliver_later
    end
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
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
        format.json { render partial: 'invitations/show' }
      else
        flash[:warning] = 'Failed to update invitation.'
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
    params.require(:invitation).permit(:invitee_id, :event_id, :host_id, :attending, recipient_ids: [])
  end
end
