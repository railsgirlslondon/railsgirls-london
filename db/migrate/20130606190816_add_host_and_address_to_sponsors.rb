class AddHostAndAddressToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :host, :boolean, null: false, default: false
    add_column :sponsors, :address_line_1, :string
    add_column :sponsors, :address_line_2, :string
    add_column :sponsors, :address_city, :string
    add_column :sponsors, :address_postcode, :string
  end
end
