class FeedbacksController < ApplicationController

  before_action :setup_properties

  def new
    if !@event.accepting_feedback?
      redirect_to event_path(@event)
    else
      @feedback = Feedback.new
    end
  end

  def create
    feedback = Feedback.create!(feedback_params.merge(event_id: @event.id))
    render template: "feedbacks/thanks"
  end

  def show
  end

  private
  def setup_properties
    @event = Event.find params[:event_id]
  end

  def feedback_params
    params.require(:feedback).permit(:email_address, :permission, :application_description,
    :application_url, :github_url, :feelings_before, :feelings_after, :comments, :rating)
  end
end
