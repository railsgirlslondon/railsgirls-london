class AddPhoneNumberToCoach < ActiveRecord::Migration
  def change
    add_column :coaches, :phone_number, :string
  end
end
