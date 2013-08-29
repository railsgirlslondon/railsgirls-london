class Invitation < ActiveRecord::Base

  belongs_to :member
  belongs_to :invitable, :polymorphic => true

  attr_accessible :invitable_type, :invitable_id, :member_id, :attending, :waiting_list, :invitable, :member

  validates :member_id, uniqueness: { scope: [:invitable_id, :invitable_type ] }

  before_create :generate_token
  after_create :send_invitation

  after_update :give_away_spot,
               :if => Proc.new { |i| i.attending == false }

  after_update :send_confirmation,
               :if => Proc.new { |i| i.attending == true and i.waiting_list == false and
                                 i.waiting_list_was == true }

  scope :accepted, -> { where(attending: true) }
  scope :waiting_list, -> { where(waiting_list: true).order('invitations.updated_at ASC') }

  default_scope -> { order('updated_at DESC') }

  def send_invitation
    invitable.email :invite, self.member, self
  end

  def send_confirmation
    invitable.email :confirm_attendance, self.member, self
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

  def give_away_spot
    invitable.process_waiting_list unless invitable.invitations.waiting_list.empty?
  end

end
