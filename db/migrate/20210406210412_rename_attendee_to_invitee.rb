class RenameAttendeeToInvitee < ActiveRecord::Migration[6.1]
  def change
    rename_column :invitations, :attendee_id, :invitee_id
  end
end
