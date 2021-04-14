module UsersHelper
  private
    def find_invitation(event)
      event.invitations.find_by(invitee_id: @user.id)
    end

    def previously_attended_events
      @user.invited_events.past.includes(:invitations).where("attending = 'yes'")      
    end
end
