class Invitation < ActiveRecord::Base

  belongs_to :member
  belongs_to :invitable, :polymorphic => true

  attr_accessible :invitable_type, :invitable_id, :member_id, :attending, :waiting_list, :invitable, :member

  validates :member_id, uniqueness: { scope: [:invitable_id, :invitable_type ] }

  after_create :send_invitation

  scope :accepted, -> { where(attending: true) }
  scope :waiting_list, -> { where(waiting_list: true) }

  def send_invitation
    invitable.email :invite, self.member
  end
end
