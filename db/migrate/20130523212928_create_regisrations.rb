class CreateRegisrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :twitter
      t.string :gender
      t.string :phone_number
      t.text :programming_experience
      t.text :reason_for_applying

      t.timestamps
    end

    add_index :registrations, :email
    add_index :registrations, :last_name
  end
end
