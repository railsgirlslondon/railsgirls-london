require "spec_helper"

feature "CRUDing invitation" do
  Given { admin_logged_in! }
  Given!(:event) { Fabricate(:event) }
  Given!(:sponsor) { Fabricate(:sponsor_with_address) }
  Given { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }

  Given!(:invitation) { Fabricate(:invitation, invitable: event) }

  context "admin viewing invitation" do

    When do
      visit admin_event_invitation_path(event, invitation)
    end

    Then do
      page.has_content? "Invitation"
      page.has_content? invitation.invitee.name
      page.has_content? I18n.l(invitation.created_at, format: :short)
    end

  end
end
