class Admin::EventsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_event, :find_cities

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)

    if @event.save
      redirect_to [:admin, @event], notice: 'Event was successfully created.'
    else
      render action: :new
    end
  end

  def edit

  end

  def update
    if @event.update_attributes(event_params)
      redirect_to [:admin, @event], notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path
  end

  def convert_attendees_to_members!
    @event = Event.find(params[:event_id])
    @members = @event.convert_attendees_to_members!

    redirect_to admin_city_members_path(@event.city, @members), notice: "The following members were created."
  end

  private

  def find_event
    @event = Event.find(params[:id]) if params[:id]
  end

  def event_params
    params.require(:event).permit(:title, :description, :city_id, :active, :city, :starts_on, :ends_on, :registration_deadline, :coachable)
  end
end
