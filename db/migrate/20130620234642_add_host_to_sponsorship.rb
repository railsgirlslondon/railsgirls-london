class AddHostToSponsorship < ActiveRecord::Migration
  def change
    add_column :sponsorships, :host, :boolean, null: false, default: false
  end
end
