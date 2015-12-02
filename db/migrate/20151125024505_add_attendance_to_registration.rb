class AddAttendanceToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :attended, :integer
    add_column :registrations, :attendance_note, :text
  end
end
