class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :host_city
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :events, :host_city_id
  end
end
