class Admin::RegistrationsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @event = Event.find(params[:event_id]) if params[:event_id]
    @registration = Registration.find params[:id]
  end
end
