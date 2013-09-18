class AddTwitterWidgetIdToCity < ActiveRecord::Migration
  def change
    add_column :cities, :twitter_widget_id, :string
  end
end
