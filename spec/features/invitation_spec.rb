require "spec_helper"

feature "CRUDing invitation" do
  Given!(:sponsor) { Fabricate(:sponsor_with_address) }
  Given { Fabricate(:hosting, sponsor: sponsor) }

  Given!(:invitation) { Fabricate(:invitation) }
  Given!(:other_invitation) { Fabricate(:invitation) }

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
