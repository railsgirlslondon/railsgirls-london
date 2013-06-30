class AddCoachableToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :coachable, :boolean
  end
end
