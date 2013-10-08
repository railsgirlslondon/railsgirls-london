require 'spec_helper'

describe "Listing cities" do
  before(:each) do
    @city = Fabricate(:city, name: "Sama")
    Fabricate(:event, city: @city)
    @inactive_event = Fabricate(:inactive_event, city: @city)
    @meeting =  Fabricate(:meeting, city: @city)

    Fabricate(:city, name: "Na")
  end

  specify "viewing and selecting cities" do
    visit root_path

    page.has_content? "Sama"
    page.has_content? "Na"

    viewing_by_link
    viewing_by_url

    check_upcoming_events
    check_past_events
    check_upcoming_meetings

    check_feedback_link
  end


  specify "viewing city's social media" do
    visit "/sama"

    @city.social_media.each do |social_media|
      page.has_content? social_media.name
    end
  end

  def viewing_by_url
    visit "/sama"
    page.has_content? "Rails Girls Sama"
  end

  def viewing_by_link
    first(:link, "Sama").click
    page.has_content? "Rails Girls Sama"
  end

  def check_upcoming_events
    find("#upcoming_event .title").text.should eq @city.upcoming_event.title
    find("#upcoming_event .description").text.should eq @city.upcoming_event.description
    find("#upcoming_event .links").text.should include "Tweet"
  end

  def check_upcoming_meetings
    page.has_content?(I18n.l(@meeting.date))
    page.has_content? @meeting.name
  end

  def check_past_events
    find("#past_events p").text.should eq @city.past_events.first.dates
  end

  def check_feedback_link
    page.has_content? "Did you attend out workshop on the #{@inactive_event.dates}"
  end
end

