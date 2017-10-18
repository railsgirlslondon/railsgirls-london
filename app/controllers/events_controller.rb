class EventsController < ApplicationController

  before_action :setup_properties
  helper_method :sponsors

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

  def sponsors
    @sponsors ||= @event.sponsors.shuffle
  end

end
