class RegistrationsController < ApplicationController
  def new
    @city = City.find_by_slug params[:city_id]
    @event = Event.find params[:event_id]
    if @event.registration_ends_on and @event.registration_ends_on > Date.today
      @registration = Registration.new
    else
      redirect_to city_event_path(@city, @event)
    end
  end

  def create
    @registration = Registration.new params[:registration].merge(event_id: params[:event_id])

    if @registration.save
      flash[:notice] = "Thanks for registering!"
      redirect_to city_path(params[:city_id])
    else
      @event = Event.find params[:event_id]
      @city = City.find_by_slug params[:city_id]
      render action: :new
    end
  end
end
