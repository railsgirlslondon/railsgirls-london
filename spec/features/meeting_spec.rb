require 'spec_helper'

feature "viewing a meeting" do

  let!(:announced_meeting) { Fabricate(:meeting) }
  let!(:unannounced_meeting) { Fabricate(:unannounced_meeting) }

  specify do
    viewing_announced_meeting
    cant_view_unannounced_meeting
  end

  def viewing_announced_meeting
    visit meeting_path(announced_meeting)
    page.has_content? announced_meeting.name
    page.has_content? announced_meeting.description
  end

  def cant_view_unannounced_meeting
    visit(meeting_path(unannounced_meeting))
    page.has_content? "No such meeting."
  end
end
