class InviteMailerPreview < ActionMailer::Preview

  def coaches_instruction
    event = Event.upcoming.first
    coach = event.coaches.first
    EventMailer.coaches_instruction(event, coach)
  end

end
