class RegistrationsController < ApplicationController
  layout 'cities'

  before_filter :setup_properties

  def new
    if @event.registrations_open?
      @registration = @event.registrations.build
    else
      redirect_to event_path(@event)
    end
  end

  def create
    @registration = @event.registrations.build(params[:registration])

    if @registration.valid?(:registration)
      @registration.save!
      RegistrationMailer.application_received(@event, @registration).deliver_now
      flash[:notice] = "Thanks for applying to our workshop.You should receive a confirmation email soon!"
      redirect_to event_path(@event)
    else
      render :action => :new
    end
  end

  private
  def setup_properties
    @event = Event.find params[:event_id]
  end
end
