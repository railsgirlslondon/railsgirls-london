class Admin::EventCoachingsController < ApplicationController
  layout 'admin'

  def create
    EventCoaching.create!(event_coaching_params)
    redirect_to edit_admin_coach_path(event_coaching_params[:coach_id])
  end

  def destroy
    EventCoaching.find(params[:id]).destroy
    redirect_to edit_admin_coach_path(params[:coach_id])
  end

  private
    def event_coaching_params
      params.require(:event_coaching).permit(:event_id, :coach_id)
    end
end
