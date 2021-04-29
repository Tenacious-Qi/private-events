class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :attending, default: "no response"
      t.integer :host_id
      t.integer :invitee_id
      t.integer :event_id

      t.timestamps
    end
    add_index :invitations, [:invitee_id, :event_id], unique: true
  end
end
