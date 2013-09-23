class AddMapUrlToSponsor < ActiveRecord::Migration
  def change
    add_column :sponsors, :map_url, :string
  end
end
