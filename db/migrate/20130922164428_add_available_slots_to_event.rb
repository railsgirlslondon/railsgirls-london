class AddAvailableSlotsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :available_slots, :integer
  end
end
