class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :member, index: true
      t.string :invitable_type
      t.boolean :attending, :default => nil, :null => true
      t.integer :invitable_id
      t.integer :member_id
      t.boolean :waiting_list

      t.timestamps
    end
  end
end
