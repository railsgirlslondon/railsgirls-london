class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :given_names
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :twitter
      t.references :city, index: true

      t.timestamps
    end
  end
end
