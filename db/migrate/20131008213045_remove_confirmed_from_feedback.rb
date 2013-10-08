class RemoveConfirmedFromFeedback < ActiveRecord::Migration
  def change
    remove_column :feedbacks, :confirmed, :boolean
  end
end
