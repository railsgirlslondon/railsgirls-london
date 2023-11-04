class Admin::RegistrationsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_event
  before_action :find_registration, only: [:show, :edit, :update, :destroy]

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(new_reg_params)
    @event.registrations << @registration

    if @registration.save
      flash[:admin_notice] = "Registration created."
      redirect_to admin_event_path(@event)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @registration.update(new_reg_params)
      flash[:admin_notice] = "Registration has been updated."
    else
      flash[:error] = @registration.errors.full_messages.join("\n")
    end

    redirect_to [:admin, @event, @registration]
  end

  def show
  end

  def destroy
    @registration.destroy
    redirect_to [:admin, @event], :admin_notice => 'Registration was deleted'
  end

  private

  def find_event
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  def find_registration
    @registration = Registration.find params[:id]
  end

  def new_reg_params
    params.require(:registration).permit(:first_name, :last_name, :email, :email_confirmation, :gender, :phone_number, :programming_experience, :reason_for_applying, :how_did_you_hear_about_us, :uk_resident, :os, :os_version, :terms_of_service, :address, :spoken_languages, :preferred_language, :twitter, :dietary_restrictions)
  end

  def registration_params
    params.require(:registration).permit(:attended, :attendance_note)
  end
end
