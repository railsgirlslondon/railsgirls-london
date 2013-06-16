class Admin::RegistrationsController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!, :find_event!

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

  def edit
    find_registration!
  end

  def update
    find_registration!
    @registration.update_attributes! params[:registration]
    redirect_to admin_event_path(@event)
  end

  def show
    find_registration!
  end

  def find_registration!
    @registration = Registration.find(params[:id])
  end

  def find_event!
    @event = Event.find(params[:event_id]) if params[:event_id]
  end
end
