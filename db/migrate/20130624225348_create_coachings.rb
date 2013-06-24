class CreateCoachings < ActiveRecord::Migration
  def change
    create_table :coachings do |t|
      t.references :coach, index: true
      t.string :coachable_type
      t.integer :coachable_id

      t.timestamps
    end
  end
end
