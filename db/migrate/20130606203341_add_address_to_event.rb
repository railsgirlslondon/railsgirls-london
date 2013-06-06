class AddAddressToEvent < ActiveRecord::Migration
  def change
    add_column :events, :address, :string
  end
end
