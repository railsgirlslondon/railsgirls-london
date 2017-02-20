class CreateMeetups < ActiveRecord::Migration[5.0]
  def change
    create_table :meetups do |t|
      t.string :title
      t.text :description
      t.datetime :starts_on
      t.integer :available_slots
      t.string :image
      t.string :address
      t.string :postcode
      t.timestamps
    end
  end
end
