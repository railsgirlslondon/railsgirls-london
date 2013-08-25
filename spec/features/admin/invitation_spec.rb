require "spec_helper"

feature "CRUDing invitation" do
  Given { admin_logged_in! }
  Given!(:city) { Fabricate(:city_with_members) }
  Given!(:meeting) { Fabricate(:meeting, city: city) }
  Given!(:sponsor) { Fabricate(:sponsor_with_address) }
  Given { Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting) }

  Given!(:invitation) { Fabricate(:invitation, invitable: meeting) }

  context "admin viewing invitation" do

    When do
      visit admin_city_meeting_invitation_path(city, meeting, invitation)
    end

    Then do
      page.has_content? "Invitation"
      page.has_content? invitation.member.name
      page.has_content? I18n.l(invitation.created_at, format: :short)
    end

  end
end
