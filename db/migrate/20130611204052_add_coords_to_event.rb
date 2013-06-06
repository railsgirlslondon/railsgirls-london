class AddCoordsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :coordinates, :string
  end
end
