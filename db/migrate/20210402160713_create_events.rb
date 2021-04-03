class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :location
      t.text :description
      t.datetime :start_time

      t.timestamps
    end
  end
end
