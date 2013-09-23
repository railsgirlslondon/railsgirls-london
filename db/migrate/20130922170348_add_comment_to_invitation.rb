class AddCommentToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :comment, :text
  end
end
