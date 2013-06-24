class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.references :sponsor, index: true
      t.string :sponsorable_type
      t.integer :sponsorable_id

      t.timestamps
    end
  end
end
