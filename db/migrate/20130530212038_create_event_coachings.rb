class CreateEventCoachings < ActiveRecord::Migration
  def change
    create_table :event_coachings do |t|
      t.references :event, null: false
      t.references :coach, null: false
    end

    add_index(:event_coachings, [:event_id, :coach_id], :unique => true)
  end
end
