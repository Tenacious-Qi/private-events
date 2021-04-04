class AddHostIdToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_column :invitations, :host_id, :integer
  end
end
