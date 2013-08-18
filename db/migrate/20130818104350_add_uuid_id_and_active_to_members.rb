class AddUuidIdAndActiveToMembers < ActiveRecord::Migration
  def change
    add_column :members, :uuid, :string
    add_column :members, :active, :boolean, null: :false, default: true
  end
end
