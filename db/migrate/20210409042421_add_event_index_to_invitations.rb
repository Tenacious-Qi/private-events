class AddEventIndexToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_index :invitations, :event_id, unique: true
  end
end
