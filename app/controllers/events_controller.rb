class EventsController < ApplicationController
  layout 'cities'

  def show
    @city = City.find_by_slug(params[:city_id])
    @event = Event.find params[:id]
  end
end

