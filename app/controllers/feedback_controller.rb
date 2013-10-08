class FeedbackController < ApplicationController

  before_action :set_event
  before_action :find_event_feedback, only: [ :show ]

  def new
    @feedback = Feedback.new
  end

  def show
    cancel_feedback
  end

  private

  def find_event_feedback
    begin
      @feedback = @event.feedbacks.find(params[:id])
    rescue
      flash[:error] = t("feedback.already_cancelled")
      redirect_to [@event.city, @event]
      return
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def cancel_feedback
    @feedback.destroy!

    flash[:notice] = t("feedback.cancel", name: @feedback.invitee.first_name)
    redirect_to [@event.city, @event]
    return
  end

end
