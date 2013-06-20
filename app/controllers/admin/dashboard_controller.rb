class Admin::DashboardController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_cities

  def index
    @active_events = Event.where(active: true)
    @meetings = Meeting.upcoming
  end

  private
  def find_cities
    @cities = City.all
  end
end
