class CoachRegistration < ActiveRecord::Base

  REQUIRED_ATTRIBUTES = [
    :first_name,
    :last_name,
    :email,
    :phone_number,
    :details
  ]

  validates *REQUIRED_ATTRIBUTES, presence: true
  validates :terms_of_service, presence: true, on: :new

  before_create :generate_token

  belongs_to :event
  belongs_to :coach

  validates :terms_of_service, :acceptance => true
  # validates :email, confirmation: true
  validates :email, uniqueness: { scope: :event_id, message: "You've already registered for this event! Sit tight, you'll hear from us soon." }
  validates :email,
          email: {
            mx: true,
            message: I18n.t('validations.errors.models.user.invalid_email')
          }

  scope :pending, -> { where(accepted: nil) }
  default_scope { order('created_at DESC') }

  def fullname
    "#{first_name} #{last_name}"
  end

  # def to_param
  #   self.token
  # end

  def valid_until_date
    invitation_sent_at + 3.days
  end

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless CoachRegistration.where(token: random_token).exists?
    end
  end

end
