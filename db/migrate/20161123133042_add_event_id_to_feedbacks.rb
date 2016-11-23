class AddEventIdToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :event_id, :integer
  end
end
