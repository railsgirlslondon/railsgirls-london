require "spec_helper"

feature "CRUDing invitation" do
  Given!(:city) { Fabricate(:city_with_members) }
  Given!(:meeting) { Fabricate(:meeting, city: city) }
  Given!(:sponsor) { Fabricate(:sponsor_with_address) }
  Given { Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting) }

  Given!(:invitation) { Fabricate(:invitation, invitable: meeting) }

  context "rsvp to the invitation" do

    Given do
      visit invitation_path(invitation)
    end

    When do
      choose("Yes")
      click_on "RSVP"
    end

    Then do
      page.has_content? "Thank you for RSVPing"
    end

  end
end
