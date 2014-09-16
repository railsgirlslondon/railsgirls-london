class CreateSocialMedia < ActiveRecord::Migration
  def change
    create_table :social_media do |t|
      t.references :city, index: true
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
