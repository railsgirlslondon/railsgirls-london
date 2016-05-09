class HomeController < ApplicationController
  def index
    @next_event = Event.next_event
    @past_events = Event.past
    @sponsors = SponsorComparator.new(@next_event).sponsors_for_logos
  end
end
