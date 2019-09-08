class AddRegistrationDeadlineEarlyBird < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :registration_deadline_early_bird, :date
  end
end
