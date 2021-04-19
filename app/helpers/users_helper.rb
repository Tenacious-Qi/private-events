module UsersHelper
  private
    def find_invitation(event)
      event.invitations.find_by(invitee_id: @user.id)
    end

    def yes_rsvps_past
      @user.received_invitations.rsvp_yes_past.includes(:event)
    end

    def yes_rsvps_future
      @user.received_invitations.rsvp_yes_future.includes(:event)  
    end

    def yes_rsvps_pending
      @user.received_invitations.rsvp_pending.includes(:event)
    end
end
