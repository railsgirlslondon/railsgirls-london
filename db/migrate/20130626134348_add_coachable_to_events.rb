class AddCoachableToEvents < ActiveRecord::Migration
  def change
    add_column :events, :coachable, :boolean
  end
end
