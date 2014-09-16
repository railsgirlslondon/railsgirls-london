class FeedbackHandler

  attr_reader :feedback

  def initialize registration
    @registration = registration
  end

  def build_feedback feedback_params
    @feedback = @registration.invitation.build_feedback(feedback_params)
  end

  def invitation_has_no_feedback?
    return true if @registration.invitation.feedback.nil?
    false
  end

  def has_invitation?
    return false if @registration.nil? or @registration.invitation.nil?
    return true
  end

  def create_feedback feedback_params
    @feedback = build_feedback(feedback_params)
    return true if @feedback.save

    false
  end
end
