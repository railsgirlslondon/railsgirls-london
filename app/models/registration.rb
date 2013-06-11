class Registration < ActiveRecord::Base

  ATTRIBUTES = [ :email,
                 :first_name,
                 :gender,
                 :last_name,
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

  attr_accessible *ATTRIBUTES, :twitter, :dietary_restrictions
  validates *ATTRIBUTES, presence: true

  belongs_to :event

  validates :terms_of_service, acceptance: true
  validates :email, confirmation: true

  def to_s
    [ :gender,
      :uk_resident,
      :programming_experience,
      :reason_for_applying,
      :spoken_languages,
      :preferred_language ].map do |information|
        "#{information.to_s.humanize}: #{send(information)}"
      end.join "\n"
  end

end
