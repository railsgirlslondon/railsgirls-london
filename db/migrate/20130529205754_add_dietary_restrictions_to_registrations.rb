class AddDietaryRestrictionsToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :dietary_restrictions, :string
  end
end
