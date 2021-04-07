class AddRsvpToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_column :invitations, :attending, :string, default: "no response"
  end
end
