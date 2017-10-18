class MeetupsController < ApplicationController

  def show
    @meetup = Meetup.find(params[:id])
    @event = Event.first
  end

end
