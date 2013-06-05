class Admin::DashboardController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!

  def index
    @active_events = Event.where(active: true)
  end
end
