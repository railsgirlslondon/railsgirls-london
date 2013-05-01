class AddSlugToHostCity < ActiveRecord::Migration
  def change
    add_column :host_cities, :slug, :string
  end
end
