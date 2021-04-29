class ChangeAttendingColumnOfInvitations < ActiveRecord::Migration[6.1]
  def change
    change_column_default :invitations, :attending, "no response"
  end
end
