class AddSelectionStateToCoachRegistration < ActiveRecord::Migration[6.1]
  def change
    add_column :coach_registrations, :accepted, :boolean
  end
end
