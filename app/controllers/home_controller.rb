class HomeController < ApplicationController
  def index
    @next_event = Event.next_event
    @past_events = Event.past
    @sponsors = Sponsor.all
  end
end
