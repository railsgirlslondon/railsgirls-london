class Admin::CoachRegistrationsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_event
  before_action :find_registration, only: [:show, :destroy]

  def new
    @registration = CoachRegistration.new
  end

  def create
    @registration = CoachRegistration.new(new_reg_params)
    @event.coach_registrations << @registration

    if @registration.save
      flash[:admin_notice] = "Registration created."
      redirect_to admin_event_path(@event)
    else
      render :new
    end
  end

  def update
    @registration = CoachRegistration.find(params[:id])
    if @registration.update(registration_params)
      flash[:admin_notice] = "Registration has been updated."
    else
      flash[:error] = @registration.errors.full_messages.join("\n")
    end

    redirect_to(:back)
  end

  def show
  end

  def destroy
    @registration.destroy
    redirect_back(fallback_location: admin_event_path(@event), :admin_notice => 'Registration was deleted')
  end

  private

  def find_event
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  def find_registration
    @registration = CoachRegistration.find params[:id]
  end

  def new_reg_params
    params.require(:coach_registration).permit(:accepted, :first_name, :last_name, :email, :phone_number, :details, :how_did_you_hear_about_us, :terms_of_service, :twitter, :dietary_restrictions)
  end

  def registration_params
    params.require(:registration).permit(:attended, :attendance_note)
  end
end
