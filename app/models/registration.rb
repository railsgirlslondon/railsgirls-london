class Registration < ActiveRecord::Base

  attr_accessible :email,
                  :first_name,
                  :gender,
                  :last_name,
                  :phone_number,
                  :programming_experience,
                  :reason_for_applying,
                  :twitter

  validates :email,
            :first_name,
            :gender,
            :last_name,
            :phone_number,
            :programming_experience,
            :reason_for_applying, presence: true

end
