class InvitationMailer < ApplicationMailer

  default from: 'joe.mccann.dev@gmail.com'

  def invitation_email
    @invitation = params[:invitation]
    @url = event_url(@invitation.event)
    mail(
      to: email_address_with_name(@invitation.invitee.email, @invitation.invitee.name),
      subject: "New Private Events Invitation"
    )
  end
end
