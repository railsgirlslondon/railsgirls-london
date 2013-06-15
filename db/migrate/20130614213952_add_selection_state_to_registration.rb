class AddSelectionStateToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :selection_state, :string
  end
end
