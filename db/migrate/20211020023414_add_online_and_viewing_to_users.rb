class AddOnlineAndViewingToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :online, :boolean, default: false
    add_column :users, :viewing, :string
  end
end
