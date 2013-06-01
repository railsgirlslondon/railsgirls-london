class AddRegistrationEndsOnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :registration_ends_on, :date
  end
end
