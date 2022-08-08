class DropMessages < ActiveRecord::Migration[7.0]
  def change
    drop_table :messages do |t|
      t.timestamps null: false
      t.text "body"
      t.integer "event_id"
      t.integer "user_id", null: false
    end
  end
end
