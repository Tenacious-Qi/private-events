class InvitationsController < ApplicationController
  before_action :authorize, only: %i[create update destroy show]

  def create
    event = Event.find(invitation_params[:event_id])
    result = InvitationsManager::InvitationsCreator.call(invitation_params)
    if result.success?
      InvitationsManager::InvitationsMailer.call(result.invitations)
      flash[:info] = 'Invitation successful!'
    else
      flash[:warning] = 'Failed to send invitation, please try again.'
    end
    redirect_to event
  end

  # for "Attend" or "Leave Event"
  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update(invitation_params)
      flash[:info] = 'RSVP updated!'
    else
      flash[:warning] = 'Failed to update invitation.'
    end
    redirect_to @invitation.event
  end

  # for "uninviting"
  def destroy
    @invitation = Invitation.find(params[:id])
    InvitationMailer.with(invitation: @invitation).uninvite_email.deliver_later
    @invitation.destroy
    flash[:info] = "Successfully uninvited #{@invitation.invitee.name}."
    redirect_to @invitation.event
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitee_id, :event_id, :host_id, :attending, recipient_ids: [])
  end
end
