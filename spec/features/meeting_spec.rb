require 'spec_helper'

feature "viewing a meeting" do
  let!(:city) { Fabricate(:city) }

  let!(:announced_meeting) { Fabricate(:meeting, city: city) }
  let!(:unannounced_meeting) { Fabricate(:unannounced_meeting, city: city) }

  specify do
    viewing_announced_meeting
    cant_view_unannounced_meeting
  end

  def viewing_announced_meeting
    visit city_meeting_path(city, announced_meeting)
    page.has_content? announced_meeting.name 
    page.has_content? announced_meeting.description 
  end

  def cant_view_unannounced_meeting
    visit(city_meeting_path(city, unannounced_meeting))
    page.has_content? "No such meeting."
  end
end
