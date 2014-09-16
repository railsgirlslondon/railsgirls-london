class AddAvailableSlotsToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :available_slots, :integer
  end
end
