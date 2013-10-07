class Feedback < ActiveRecord::Base
  belongs_to :invitation

  has_one :invitable, through: :invitation, source: :invitable
  has_one :invitee, through: :invitation

  attr_accessor :email_address

  attr_accessible :email_address,
                  :invitation_id,
                  :application_description,
                  :application_url,
                  :github_url,
                  :feelings_before,
                  :feelings_after,
                  :comments

  def pending_confirmation?
    not(self.confirmed.eql?(true))
  end

  def confirm!
    self.update_attribute(:confirmed, true)
  end

end
