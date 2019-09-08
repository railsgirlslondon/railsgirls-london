class HomeController < ApplicationController
  def index
    @next_event = Event.upcoming.first
    @past_events = Event.past
    @sponsors = SponsorComparator.new(@next_event).sponsors_for_logos
  end

  def code_of_conduct
  end
end
