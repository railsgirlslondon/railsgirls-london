class Admin::EventsController < ApplicationController
  layout 'admin'

  before_filter :find_event
  before_filter :authenticate_user!

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new params[:event]
    if @event.save
      redirect_to [:admin, @event], notice: 'Event was successfully created.'
    else
      render action: :new
    end
  end

  def edit
    
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to [:admin, @event], notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path
  end

  private
  def find_event
    @event = Event.find(params[:id]) if params[:id]
  end
end
