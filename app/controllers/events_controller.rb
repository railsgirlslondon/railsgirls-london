class EventsController < ApplicationController
  layout 'cities'

  def show
    @city = City.find_by_slug(params[:city_id])
    @event = Event.find_by_slug(params[:id])
  end
end

