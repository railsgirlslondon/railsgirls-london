class RegistrationsController < ApplicationController
  layout 'cities'

  before_filter :setup_properties

  def new
    if @event.registrations_open?
      @registration = @event.registrations.build
    else
      redirect_to city_event_path(@city, @event)
    end
  end

  def create
    @registration = @event.registrations.build(params[:registration])

    if @registration.valid?(:registration)
      @registration.save!
      RegistrationMailer.application_received(@event, @registration).deliver_now
      flash[:notice] = "Thanks for applying to our workshop.You should receive a confirmation email soon!"
      redirect_to city_path(params[:city_id])
    else
      render action: :new
    end
  end

  private
  def setup_properties
    @city = City.find_by_slug params[:city_id]
    @event = Event.find params[:event_id]
  end
end
