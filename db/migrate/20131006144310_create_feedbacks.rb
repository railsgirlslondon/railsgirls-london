class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :application_url
      t.string :application_description
      t.string :github_url
      t.string :feelings_before
      t.string :feelings_after
      t.string :comments
      t.references :invitation

      t.timestamps
    end
  end
end
