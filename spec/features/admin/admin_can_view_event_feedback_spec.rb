require 'spec_helper'

feature 'an admin can view attendee feedback' do
  let! (:event) { Fabricate(:event) }
  let! (:sponsor) { Fabricate(:sponsor_with_address) }
  let!(:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }
  let! (:registration) { Fabricate(:registration, event: event) }
  let! (:invitation) { Fabricate(:event_invitation, invitable: event, invitee: registration) }
  let! (:feedback) { Fabricate(:feedback, invitation_id: invitation.id) }
  before do
    admin_logged_in!
  end
end
