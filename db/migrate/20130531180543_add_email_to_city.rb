class AddEmailToCity < ActiveRecord::Migration
  def change
    add_column :cities, :email, :string
  end
end
