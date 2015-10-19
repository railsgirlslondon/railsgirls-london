class HomeController < ApplicationController
  def index
    @upcoming_event = Event.upcoming
    @past_events = Event.past
    @sponsors = Sponsor.all
  end
end
