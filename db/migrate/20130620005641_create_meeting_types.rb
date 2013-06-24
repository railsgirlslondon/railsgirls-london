class CreateMeetingTypes < ActiveRecord::Migration
  def change
    create_table :meeting_types do |t|
      t.string :name
      t.text :description
      t.string :frequency

      t.timestamps
    end
  end
end
