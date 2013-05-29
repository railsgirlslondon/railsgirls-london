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
                 :event_id ]

  attr_accessible *ATTRIBUTES, :twitter, :dietary_restrictions
  validates *ATTRIBUTES, presence: true

  belongs_to :event
end
