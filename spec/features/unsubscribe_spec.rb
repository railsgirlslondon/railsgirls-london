require 'spec_helper'

feature "Unsubscribe from emails" do

  let!(:member) { Fabricate(:member, active: true) }
  let!(:event) { Fabricate(:event) }
  let!(:host) { Fabricate(:hosting, sponsorable_type: 'Event', sponsorable_id: event.id) }

  specify do
    pending("fix this one")
    visit unsubscribe_path(member.uuid)

    expect(page).to have_content("Are you sure you want to unsubscribe?")

    click_on "Yes"

    expect(page).to have_content("Thanks for your participation.")
  end
end
