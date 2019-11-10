class Registration < ActiveRecord::Base
  has_one :invitation, foreign_key: :invitee_id

  include Extentions::Attendable # Allows for tracking whether a student showed up (and why/why not)

  REQUIRED_ATTRIBUTES = [
    :first_name,
    :last_name,
    :email,
    :phone_number,
    :gender,
    :address,
    :reason_for_applying,
    :terms_of_service
  ]

  validates *REQUIRED_ATTRIBUTES, presence: true

  belongs_to :event
  belongs_to :member

  validates :terms_of_service, :acceptance => true
  validates :email, confirmation: true
  validates :email, uniqueness: { scope: :event_id, message: "You've already registered for this event! Sit tight, you'll hear from us soon." }

  scope :accepted, -> { where(selection_state: "accepted", attending: true) }
  scope :members,  -> { where(Registration.arel_table[:member_id].not_eq(nil)) }

  default_scope -> { order(created_at: :desc) }

  def fullname
    "#{first_name} #{last_name}"
  end

  def name
    fullname
  end

  def forename
    first_name
  end

  def to_s
    [
      :fullname,
      :gender,
      :uk_resident,
      :programming_experience,
      :spoken_languages,
      :preferred_language
    ].map do |information|
      "#{information.to_s.humanize}: #{send(information)}"
    end.join "\n"
  end

  def mark_selection(selection_state)
    update_attribute :selection_state, selection_state
  end

end
