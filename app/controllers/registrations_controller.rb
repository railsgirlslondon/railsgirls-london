class RegistrationsController < ApplicationController
  before_filter :setup_properties

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new params[:registration].merge(event_id: params[:event_id])

    if @registration.save
      RegistrationMailer.application_received(@event, @registration, request_url).deliver
      flash[:notice] = "Thanks for registering! You should receive an email confirming your application soon."
      redirect_to city_path(params[:city_id])
    else
      render action: :new
    end
  end

  private
  def request_url
    request.protocol + request.host_with_port
  end

  def setup_properties
    @city = City.find_by_slug params[:city_id]
    @event = Event.find params[:event_id]
  end
end
