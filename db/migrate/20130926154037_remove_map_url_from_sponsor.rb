class RemoveMapUrlFromSponsor < ActiveRecord::Migration
  def change
    remove_column :sponsors, :map_url
  end
end
