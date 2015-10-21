class EventsController < ApplicationController

  before_filter :setup_properties

  def show
    @event = Event.find params[:id]
    if @event.registrations_open?
      @registration = @event.registrations.build
    end
  end

  private
  def setup_properties
    @event = Event.find params[:id]
  end

end
