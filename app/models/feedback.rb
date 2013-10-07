class Feedback < ActiveRecord::Base
  belongs_to :invitation

  has_one :invitable, through: :invitation, source: :invitable, source_type: "Event"
  has_one :invitee, through: :invitation, source: :invitee, source_type: "Registration"

  has_one :city, through: :invitable

  after_create :send_feedback_confirmation

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

  def send_feedback_confirmation
    invitable.email :confirm_feedback, invitee, invitee.invitation
  end

end
