class AddTwitterToCity < ActiveRecord::Migration
  def change
    add_column :cities, :twitter, :string
  end
end
