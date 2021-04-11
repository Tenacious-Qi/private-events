module InvitationsHelper
  
  def duplicate_invitation?
    @invitation = Invitation.find(params[:id])
    invitee = @invitation.invitee
    event = @invitation.event
    if @invitation.invitee_id == invitee.id && @invitation.event_id == event.id
      redirect_to @invitation.event
    end
  end
end
