class AddIndexToCitySlug < ActiveRecord::Migration
  def change
    add_index :cities, :slug
  end
end
