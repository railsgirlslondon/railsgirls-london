class AddOrganiserToCoachings < ActiveRecord::Migration
  def change
    add_column :coachings, :organiser, :boolean
  end
end
