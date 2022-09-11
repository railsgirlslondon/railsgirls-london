class CreateCoachRegistration < ActiveRecord::Migration[6.1]
  def change
    create_table :coach_registrations do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :twitter
      t.string :phone_number
      t.text :details
      t.string :dietary_restrictions
      t.text :how_did_you_hear_about_us
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
