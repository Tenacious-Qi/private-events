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

  def uninvite_email
    @invitation = params[:invitation]
    mail(
      to: email_address_with_name(@invitation.invitee.email, @invitation.invitee.name),
      subject: "You have been uninvited from an event"
    )
  end
end
