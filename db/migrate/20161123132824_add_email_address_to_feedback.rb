class AddEmailAddressToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :email_address, :string
  end
end
