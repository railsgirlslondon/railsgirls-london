require "spec_helper"

feature "CRUDing invitation" do
  Given!(:sponsor) { Fabricate(:sponsor_with_address) }
  Given!(:event) { Fabricate(:event) }
  Given { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }

  Given!(:invitation) { Fabricate(:invitation, invitable: event) }
  Given!(:other_invitation) { Fabricate(:invitation, invitable: event) }

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

end
