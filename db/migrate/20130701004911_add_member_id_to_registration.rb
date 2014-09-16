class AddMemberIdToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :member_id, :integer
  end
end
