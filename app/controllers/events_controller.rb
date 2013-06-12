class EventsController < ApplicationController
  layout 'cities'

  def show
    @city = City.find_by_slug(params[:city_id])
    @event = @city.events.find_by_slug(params[:id])
  end
end

