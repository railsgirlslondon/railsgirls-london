class AddTokenToCoachRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :coach_registrations, :token, :string
  end
end
