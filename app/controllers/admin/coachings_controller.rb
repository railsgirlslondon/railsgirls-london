class Admin::CoachingsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def create
    Coaching.create!(event_coaching_params)
    redirect_to edit_admin_coach_path(event_coaching_params[:coach_id])
  end

  def destroy
    Coaching.find(params[:id]).destroy
    redirect_to edit_admin_coach_path(params[:coach_id])
  end

  private
    def event_coaching_params
      params.require(:coaching).permit(:coachable_id, :coachable_type, :coach_id)
    end
end
