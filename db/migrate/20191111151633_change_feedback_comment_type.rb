class ChangeFeedbackCommentType < ActiveRecord::Migration[5.0]
  def change
    change_column :feedbacks, :comments, :text
    change_column :feedbacks, :feelings_before, :text
  end
end
