class AddEventIdToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :event_id, :integer
  end
end