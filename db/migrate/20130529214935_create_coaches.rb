class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :twitter
      t.string :email

      t.timestamps
    end
  end
end
