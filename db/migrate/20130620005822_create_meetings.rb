class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :date
      t.boolean :announced
      t.references :city, index: true
      t.references :meeting_type, index: true

      t.timestamps
    end
  end
end
