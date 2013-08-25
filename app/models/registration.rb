class Registration < ActiveRecord::Base
  REQUIRED_ATTRIBUTES = [:first_name,
                         :last_name,
                         :email]

  REGISTRATION_ATTRIBUTES = [:gender,
                             :phone_number,
                             :programming_experience,
                             :reason_for_applying,
                             :uk_resident,
                             :os,
                             :os_version,
                             :spoken_languages,
                             :preferred_language,
                             :address,
                             :event_id,
                             :event,
                             :terms_of_service,
                             :email_confirmation]

  attr_accessible(*(REQUIRED_ATTRIBUTES + REGISTRATION_ATTRIBUTES),
                  :twitter,
                  :dietary_restrictions,
                  :selection_state,
                  :attending,
                  :member)

  validates *REQUIRED_ATTRIBUTES, :presence => true
  validates *REGISTRATION_ATTRIBUTES, :presence => true, :on => 'registration'

  belongs_to :event
  belongs_to :member

  validates :terms_of_service, :acceptance => true
  validates :email, :confirmation => true

  scope :accepted, -> { where(selection_state: "accepted", attending: true) }
  scope :members, -> { where(Registration.arel_table[:member_id].not_eq(nil)) }

  def fullname
    "#{first_name} #{last_name}"
  end

  def to_s
    [:fullname,
     :gender,
     :uk_resident,
     :programming_experience,
     :spoken_languages,
     :preferred_language].map do |information|
       "#{information.to_s.humanize}: #{send(information)}"
     end.join "\n"
  end

  def mark_selection(selection_state)
    update_attribute :selection_state, selection_state
  end

end
