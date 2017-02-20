class AddColumnsToMeetups < ActiveRecord::Migration[5.0]
  def change
    add_column :meetups, :location_website, :string
    add_column :meetups, :location_name, :string
  end
end
