class RemoveIndexAgainFromInvitations < ActiveRecord::Migration[6.1]
  def change
    remove_index :invitations, name: "index_invitations_on_event_id"
  end
end
