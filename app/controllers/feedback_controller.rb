class FeedbackController < ApplicationController

  before_action :set_event
  before_action :find_event_feedback, only: [ :show ]

  def new
    @feedback = Feedback.new
  end

  def show
    return confirm_feedback if @feedback.pending_confirmation?

    already_confirmed
  end

  private

  def find_event_feedback
    @feedback = @event.feedbacks.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def confirm_feedback
    if @feedback.pending_confirmation?
      @feedback.confirm!

      flash[:notice] = t("feedback.confirmation.successful", name: @feedback.invitee.first_name)
      redirect_to [@event.city, @event]
      return
    end
  end

  def already_confirmed
    flash[:error] = t("feedback.already_confirmed")
    redirect_to [@event.city, @event]
    return
  end

end
