class HomeController < ApplicationController
  def index
    @events = Event.upcoming

  end
end
