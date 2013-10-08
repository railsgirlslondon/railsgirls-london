class HomeController < ApplicationController
  def index
    @events = Event.upcoming
    @cities = City.all if @events.empty?
  end
end
