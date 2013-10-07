class FeedbacksController < ApplicationController

  include MessageManager

  before_action :set_event
  before_action :set_registration, only: [ :create ]

  def index
  end

  def create
    @feedback = Feedback.new(feedback_params)

    process_feedback_for(@registration)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email_address, :comments, :application_description, :application_url, :github_url, :feelings_before, :feelings_after)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def create_feedback_for registration
    feedback_handler = FeedbackHandler.new(registration)

    if feedback_handler.create_feedback(feedback_params)

      flash[:notice] = t("feedback.successful", name: registration.first_name)
      return redirect_to [ @event.city, @event]
    end

    @feedback = feedback_handler.feedback
    render_error 'feedback/new', "Hm.. Something is not right #{@feedback.errors}"
  end

  def process_feedback_for registration
    if FeedbackHandler.new(registration).has_invitation?
      return create_feedback_for(registration) if FeedbackHandler.new(registration).invitation_has_no_feedback?

      render_error "feedback/new",
        t("feedback.already_submitted", name: registration.first_name )
    else
      render_error "feedback/new",
        t("feedback.error.cannot_find_user", email: @event.city.email ).html_safe
    end
  end

  def set_registration
    @registration ||= @event.registrations.find_by(email: feedback_params[:email_address])
  end
end
