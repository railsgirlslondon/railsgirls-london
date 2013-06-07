class MoveHostFlagToEventSponsorshipRelation < ActiveRecord::Migration
  def change
    remove_column :sponsors, :host
    add_column :event_sponsorships, :host, :boolean, null: false, default: false

    add_index "event_sponsorships", "host", name: "index_event_sponsorships_on_host"
  end
end
