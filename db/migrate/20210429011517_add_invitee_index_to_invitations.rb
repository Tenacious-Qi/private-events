class AddInviteeIndexToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_index :invitations, [:invitee_id, :event_id], unique: true
  end
end
