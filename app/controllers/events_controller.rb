class EventsController < ApplicationController
  layout 'cities'

  def show
    @event = Event.find params[:id]
  end
end

