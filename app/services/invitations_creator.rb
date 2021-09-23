class InvitationsCreator < ApplicationService
  attr_reader :recipient_ids, :rsvp_info

  def initialize(params)
    @recipient_ids = params[:recipient_ids]
    @rsvp_info = params.except(:recipient_ids)
  end

  def call
    result = nil
    recipient_ids.each do |id|
      invitation = Invitation.create!(rsvp_info.merge(invitee_id: id))
    rescue ActiveRecord::RecordInvalid => e
      return OpenStruct.new({ success?: false, error: e })
    else
      send_email(invitation)
      result = OpenStruct.new({ success?: true })
    end
    result
  end

  private

  def send_email(invitation)
    InvitationMailer.with(invitation: invitation).invitation_email.deliver_later
  end
end
