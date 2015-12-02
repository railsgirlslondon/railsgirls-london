class AddAttendanceToCoaching < ActiveRecord::Migration
  def change
    add_column :coachings, :attended, :integer
    add_column :coachings, :attendance_note, :text
  end
end
