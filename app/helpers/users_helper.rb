module UsersHelper
  private
    def yes_rsvps_past
      @user.received_invitations.rsvp_yes_past.includes(:event)
    end

    def yes_rsvps_future
      @user.received_invitations.rsvp_yes_future.includes(:event)  
    end

    def rsvps_pending
      @user.received_invitations.rsvp_pending.includes(:event)
    end

    def no_rsvps_future
      @user.received_invitations.rsvp_attendance_canceled.includes(:event)
    end
end
