class RegistrationsController < ApplicationController

  before_action :setup_properties

  def new
    if @event.accepting_registrations?
      @registration = @event.registrations.build
    else
      redirect_to event_path(@event)
    end
  end

  def create
    @registration = @event.registrations.build(registration_params)

    if @registration.valid?(:registration)
      @registration.save!
      RegistrationMailer.application_received(@event, @registration).deliver_now
      flash[:notice] = "Thanks for applying to our workshop. You should receive a confirmation email soon!"
      redirect_to event_path(@event)
    else
      error_messages = @registration.errors.full_messages.join(', ')
      flash[:alert] = "Please correct the errors: #{error_messages}"
      render template: 'events/show'
    end
  end

  private
  def setup_properties
    @event = Event.find params[:event_id]
  end

  def registration_params
    params.require(:registration).permit(:first_name, :last_name, :email, :email_confirmation, :gender, :phone_number, :programming_experience, :reason_for_applying, :how_did_you_hear_about_us, :uk_resident, :os, :os_version, :terms_of_service, :address, :spoken_languages, :preferred_language, :twitter, :dietary_restrictions)
  end
end
