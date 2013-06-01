class AddImageUrlToSponsor < ActiveRecord::Migration
  def change
    add_column :sponsors, :image_url, :string
  end
end
