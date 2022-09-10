class AddCoachIdToCoachRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_reference :coach_registrations, :coach
  end
end
