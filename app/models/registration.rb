class Registration < ActiveRecord::Base
  ATTRIBUTES = [:email,
                :first_name,
                :gender,
                :last_name,
                :phone_number,
                :programming_experience,
                :reason_for_applying,
                :twitter]

  attr_accessible *ATTRIBUTES
  validates *ATTRIBUTES, presence: true

end
