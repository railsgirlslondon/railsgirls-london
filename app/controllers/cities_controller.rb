class CitiesController < ApplicationController
  layout 'cities'

  before_filter :find_city

  def show
    @upcoming_meetings = @city.meetings.upcoming.announced
    @latest_event = @city.events.order("ends_on desc").first
  end

  def sponsor
    render layout: 'application'
  end

  private

  def find_city
    unless (@city = City.find_by_slug(params[:id]))
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
