class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :primary_contact_email
      t.text :description
    end
  end
end
