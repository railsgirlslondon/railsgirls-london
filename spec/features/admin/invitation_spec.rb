require "spec_helper"

feature "CRUDing invitation" do
  Given { admin_logged_in! }
  Given!(:meeting) { Fabricate(:meeting) }
  Given!(:sponsor) { Fabricate(:sponsor_with_address) }
  Given { Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting) }

  Given!(:invitation) { Fabricate(:invitation, invitable: meeting) }

  context "admin viewing invitation" do

    When do
      visit admin_meeting_invitation_path(meeting, invitation)
    end

    Then do
      page.has_content? "Invitation"
      page.has_content? invitation.invitee.name
      page.has_content? I18n.l(invitation.created_at, format: :short)
    end

  end
end
