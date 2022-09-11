class Admin::CoachingsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def create
    coaching = Coaching.create!(event_coaching_params)
    flash[:notice] = "#{coaching.coach.name} has been assigned to #{coaching.coachable.to_s}."
    redirect_back(fallback_location: admin_coach_path(event_coaching_params[:coach_id]))
  end

  def destroy
    coaching = Coaching.find(params[:id]).destroy
    flash[:notice] = "#{coaching.coach.name} has been removed from #{coaching.coachable.to_s}.".html_safe
    redirect_back(fallback_location: admin_coach_path(coaching.coach.id))
  end

  def update
    coaching = Coaching.find(params[:id])

    if coaching.update(event_coaching_params)
      flash[:notice] = "#{coaching.coach.name} coaching has been updated.".html_safe
    else
      flash[:error] = coaching.errors.full_messages.join("\n")
    end

    redirect_back(fallback_location: admin_coach_path(coaching.coach))
  end

  private
    def event_coaching_params
      params.require(:coaching).permit(:coachable_id, :coachable_type, :coach_id, :organiser, :attended, :attendance_note)
    end
end
