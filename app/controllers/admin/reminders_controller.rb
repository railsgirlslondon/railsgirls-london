class Admin::RemindersController < ApplicationController

  def day_before_the_event
    event = Event.find(params[:event_id])
    if event.send_reminders
      redirect_to :back
    end
  end

end
