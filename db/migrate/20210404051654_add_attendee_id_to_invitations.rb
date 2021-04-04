class AddAttendeeIdToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_column :invitations, :attendee_id, :integer
    add_column :invitations, :event_id, :integer
  end
end
