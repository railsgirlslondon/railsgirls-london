class CreateHostCities < ActiveRecord::Migration
  def change
    create_table :host_cities do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
