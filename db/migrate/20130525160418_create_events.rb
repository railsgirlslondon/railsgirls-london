class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :description
      t.references :city
      t.boolean :active

      t.timestamps
    end
  end
end
