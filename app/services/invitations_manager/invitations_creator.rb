module InvitationsManager
  class InvitationsCreator < ApplicationService
    attr_reader :recipient_ids, :rsvp_info

    def initialize(params)
      @recipient_ids = params[:recipient_ids]
      @rsvp_info = params.except(:recipient_ids)
    end

    def call
      invitations_data = recipient_ids.map { |id| rsvp_info.merge(invitee_id: id) }
      invitations = Invitation.transaction do
        Invitation.create!(invitations_data)
      end
    rescue ActiveRecord::RecordInvalid => e
      OpenStruct.new({ success?: false, error: e })
    else
      OpenStruct.new({ success?: true, invitations: invitations })
    end
  end
end