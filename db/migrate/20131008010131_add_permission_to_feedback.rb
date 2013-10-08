class AddPermissionToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :permission, :boolean
  end
end
