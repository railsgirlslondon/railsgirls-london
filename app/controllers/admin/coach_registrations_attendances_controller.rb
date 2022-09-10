class Admin::CoachRegistrationsAttendancesController < Admin::CoachRegistrationsController


  def update
    @registration = CoachRegistration.find(params[:coach_registration_id])
    @registration.update!(accepted: true, invitation_sent_at: Time.now, terms_of_service: true)
    event = Event.find(params[:event_id])
    CoachRegistrationMailer.coach_accepted(event, @registration).deliver_now
    redirect_to admin_event_path(params[:event_id])
  end
end
