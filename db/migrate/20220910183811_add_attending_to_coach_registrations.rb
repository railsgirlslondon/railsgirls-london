class AddAttendingToCoachRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :coach_registrations, :attending, :boolean
    add_column :coach_registrations, :comment, :text
    add_column :coach_registrations, :invitation_sent_at, :datetime
  end
end
