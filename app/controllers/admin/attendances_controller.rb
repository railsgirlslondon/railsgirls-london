class Admin::AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    toggle_attendance!
  end

  def destroy
    toggle_attendance!
  end

  private

  def toggle_attendance!
    registration = Registration.find(params[:registration_id])
    registration.toggle!(:attending)
    redirect_to admin_event_path(params[:event_id])
  end
end
