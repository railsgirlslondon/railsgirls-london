class AddAcceptingFeedbackBooleanToEvents < ActiveRecord::Migration
  def change
    add_column :events, :accepting_feedback, :boolean, null: false, default: false
  end
end
