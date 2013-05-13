class AddTwitterUsernameToHostCity < ActiveRecord::Migration
  def change
    add_column :host_cities, :twitter, :string
  end
end
