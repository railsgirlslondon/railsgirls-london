class Admin::AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    toggle_acceptance!
  end

  def destroy
    toggle_acceptance!
  end

  private

  def toggle_acceptance!
    registration = Registration.find(params[:registration_id])
    acceptance = registration.selection_state.eql?("accepted") ? "" : "accepted"
    registration.update_attribute(:selection_state, acceptance)

    redirect_to admin_event_path(params[:event_id])
  end
end
