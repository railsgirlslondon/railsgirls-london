class AddEventToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :event_id, :integer
  end
end
