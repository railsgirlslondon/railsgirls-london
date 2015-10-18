class Admin::DashboardController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def index
    @active_events = Event.where(:active => true)
    @meetings = Meeting.upcoming
  end
end
