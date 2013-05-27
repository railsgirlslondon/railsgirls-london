class AddStartsOnAndEndsOnOnEvent < ActiveRecord::Migration
  def change
    add_column :events, :starts_on, :date
    add_column :events, :ends_on, :date
  end
end
