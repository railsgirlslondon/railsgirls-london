class Admin::RegistrationInviteController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def create
    event.invite(registration)
    redirect_to :back
  end


  private

  def event
    @event ||= Event.find(params[:event_id])
  end

  def registration
    @registration ||= Registration.find(params[:registration_id])
  end

end
