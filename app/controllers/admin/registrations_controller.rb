class Admin::RegistrationsController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!, :find_event
  before_filter :find_registration, only: [:show, :destroy]

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])
    @event.registrations << @registration

    if @registration.save
      flash[:notice] = "Registration created."
      redirect_to admin_event_path(@event)
    else
      render :new
    end
  end

  def update
    @registration = Registration.find(params[:id])
    if @registration.update_attributes(registration_params)
      flash[:notice] = "Registration has been updated."
    else
      flash[:error] = @registration.errors.full_messages.join("\n")
    end

    redirect_to(:back)
  end

  def show
  end

  def destroy
    @registration.destroy
    redirect_to [:admin, @event], :notice => 'Registration was deleted'
  end

  private

  def find_event
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  def find_registration
    @registration = Registration.find params[:id]
  end

  def registration_params
    params.require(:registration).permit(:attended, :attendance_note)
  end
end
