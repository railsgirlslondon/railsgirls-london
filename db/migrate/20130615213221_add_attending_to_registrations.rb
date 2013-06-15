class AddAttendingToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :attending, :boolean, null: false, default: false
  end
end
