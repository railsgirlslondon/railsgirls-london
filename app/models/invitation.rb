class Invitation < ActiveRecord::Base

  belongs_to :member
  belongs_to :invitable, :polymorphic => true

  attr_accessible :invitable_type, :invitable_id, :member_id, :attending, :waiting_list, :invitable, :member

  validates :member_id, uniqueness: { scope: [:invitable_id, :invitable_type ] }

  before_create :generate_token
  after_create :send_invitation

  scope :accepted, -> { where(attending: true) }
  scope :waiting_list, -> { where(waiting_list: true) }

  def send_invitation
    invitable.email :invite, self.member, self
  end

  def to_param
    self.token
  end

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Invitation.where(token: random_token).exists?
    end
  end

end
