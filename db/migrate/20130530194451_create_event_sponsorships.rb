class CreateEventSponsorships < ActiveRecord::Migration
  def change
    create_table :event_sponsorships do |t|
      t.references :event, null: false
      t.references :sponsor, null: false
    end

    add_index(:event_sponsorships, [:event_id, :sponsor_id], unique: true)
  end
end
