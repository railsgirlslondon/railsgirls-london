class CoachRegistrationsController < ApplicationController

  before_action :setup_properties, only: [:new, :create]
  before_action :registration, only: [:show, :update]

  # used to apply
  def new
    if @event.registrations_open?
      @registration = @event.coach_registrations.build
    else
      redirect_to event_path(@event)
    end
  end

  def create
    @registration = @event.coach_registrations.build(registration_params)

    if @registration.valid?(:coach_registration)
      @registration.save!
      CoachRegistrationMailer.coach_application_received(@event, @registration).deliver_now
      flash[:notice] = "Thanks for applying to our workshop. You should receive a confirmation email soon!"
      redirect_to new_event_coach_registration_path(@event), notice: flash[:notice]
    else
      error_messages = @registration.errors.full_messages.join(', ')
      flash[:alert] = "Please correct the errors: #{error_messages}"
      render template: 'coach_registrations/new'

    end

  end


  # used to mark the attendance as true or false
  def show
    @event = @registration.event
    @attendance_status = params[:attending]
  end

  def update
    if @registration.update!(confirmation_registration_params)
      if @registration.attending?
        Coaching.create!(event_coaching_params)
      else
        Coaching.find_by(event_coaching_params)&.delete
      end
    end

    flash[:notice] = "Thank you for your response."
    redirect_back(fallback_location: coach_registration_path(@registration.token))
  end


  private

  def event_coaching_params
    { coachable: @registration.event, coachable_type: "Event", coach: @registration.coach }
  end

  def setup_properties
    @event = Event.find params[:event_id]
  end

  def registration
    @registration = CoachRegistration.find_by(token: params[:token])
  end

  def registration_params
    params.require(:coach_registration).permit(:first_name, :last_name, :email, :phone_number, :details, :how_did_you_hear_about_us, :terms_of_service, :twitter, :twitter, :dietary_restrictions)
  end

  def confirmation_registration_params
    params.require(:coach_registration).permit(:attending, :comment)
  end
end
