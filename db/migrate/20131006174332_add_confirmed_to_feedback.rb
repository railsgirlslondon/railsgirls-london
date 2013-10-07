class AddConfirmedToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :confirmed, :boolean
  end
end
