require 'spec_helper'

feature 'a user can provide feedback for an invitable event' do
  let! (:event) { Fabricate(:event) }
  let! (:sponsor) { Fabricate(:sponsor_with_address) }
  let! (:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }

  scenario "only if they have attented the event" do
    fill_in_feedback_form event, "some email"

    expect(page).to have_content "Hm.. We can't seem to find you."
    expect(page).to have_content event.city.email
  end

  let! (:registration) { Fabricate(:registration, email: "some@email.com", event: event) }
  let! (:invitation) { Fabricate(:event_invitation, invitable: event, invitee: registration) }


  scenario "only once" do
    fill_in_feedback_form event, registration.email
    expect(page).to have_content "Thanks for your feedback #{registration.first_name}."

    fill_in_feedback_form event,  registration.email
    expect(page).to have_content "Hi #{registration.first_name}! We've already received you feedback for this event"
  end

end

private

def fill_in_feedback_form event, email
    visit new_city_event_feedback_path(event.city, event)

    fill_in 'Email address', with: email
    fill_in 'Application description', with: "A listing application"
    fill_in 'Application url', with: "http://some/application.url"

    select "Meh", from: 'How would you rate our workshop? *'
    check "Can we use your feedback and comments on our website?"

    click_on "Submit"
end
