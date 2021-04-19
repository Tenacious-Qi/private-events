module UsersHelper
  private
    def find_invitation(event)
      event.invitations.find_by(invitee_id: @user.id)
    end

    def previously_attended_events
      @user.invited_events.past.includes(:invitations).where("attending = 'yes'")      
    end

    def events_planning_to_attend
      @user.invited_events.upcoming.includes(:invitations).where("attending = 'yes'")
    end

    def events_with_pending_rsvp
      @user.invited_events.upcoming.includes(:invitations).where("attending = 'no response'")
    end
end
