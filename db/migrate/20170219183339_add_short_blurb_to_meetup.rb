class AddShortBlurbToMeetup < ActiveRecord::Migration[5.0]
  def change
    add_column :meetups, :short_blurb, :string
  end
end
