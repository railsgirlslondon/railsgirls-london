class Feedback < ActiveRecord::Base
  attr_accessible :email_address,
                  :invitation_id,
                  :application_description,
                  :application_url,
                  :github_url,
                  :feelings_before,
                  :feelings_after,
                  :comments,
                  :rating,
                  :permission,
                  :event_id
end
