class AddFieldsToCoach < ActiveRecord::Migration[5.0]
  def change
    add_column :coaches, :dietary_restrictions, :string
    add_column :coaches, :notes, :string
  end
end
