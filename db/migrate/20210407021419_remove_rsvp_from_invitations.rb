class RemoveRsvpFromInvitations < ActiveRecord::Migration[6.1]
  def change
    remove_column :invitations, :attending
  end
end
