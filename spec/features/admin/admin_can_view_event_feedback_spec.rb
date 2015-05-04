require 'spec_helper'

feature 'an admin can view attendee feedback' do
  let! (:city) { Fabricate(:city) }
  let! (:event) { Fabricate(:event, city: city) }
  let! (:sponsor) { Fabricate(:sponsor_with_address) }
  let!(:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }
  let! (:registration) { Fabricate(:registration, event: event) }
  let! (:invitation) { Fabricate(:event_invitation, invitable: event, invitee: registration) }
  let! (:feedback) { Fabricate(:feedback, invitation_id: invitation.id) }
  before do
    admin_logged_in!
  end

  scenario "for city events" do

    visit admin_city_path(event.city)

    click_on "Attendee feedback"
    expect(page).to have_content invitation.invitee.name

    click_on "View feedback"
    expect(page).to have_content feedback.comments
  end
end
