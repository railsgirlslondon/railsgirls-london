require "spec_helper"

feature "CRUDing invitation" do
  Given!(:city) { Fabricate(:city_with_members) }
  Given!(:meeting) { Fabricate(:meeting, city: city, available_slots: 1) }
  Given!(:sponsor) { Fabricate(:sponsor_with_address) }
  Given { Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting) }

  Given!(:invitation) { Fabricate(:invitation, invitable: meeting) }
  Given!(:other_invitation) { Fabricate(:invitation, invitable: meeting) }

  context "rsvp to the invitation" do

    Given do
      visit invitation_path(invitation)
    end

    When do
      choose("Yes")
      click_on "RSVP"
    end

    Then do
      page.has_content? "Thank you for your response."
    end

  end

  context "waiting list" do
    Given do
      visit invitation_path(invitation)
      choose("Yes")
      click_on "RSVP"

      visit invitation_path(other_invitation)
    end

    When do
      click_on "Join the waiting list"
    end

    Then do
      page.has_content? "Thank you for your response."
    end

  end
end
