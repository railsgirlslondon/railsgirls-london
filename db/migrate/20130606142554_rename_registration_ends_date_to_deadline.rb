class RenameRegistrationEndsDateToDeadline < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.rename :registration_ends_on, :registration_deadline
    end
  end
end
