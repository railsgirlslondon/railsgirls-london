class ChangeMemberToInvitee < ActiveRecord::Migration
  def change
    rename_column :invitations, :member_id, :invitee_id
    add_column :invitations, :invitee_type, :string
  end
end
