class Admin::SuggestedMatchesController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def index
    @registration = CoachRegistration.find(params[:coach_registration_id])
    @event = @registration.event
    @coaches = Coach.where(email: @registration.email).or(Coach.where("name like ?", "%#{@registration.last_name}%"))
  end

  def create
    @registration = CoachRegistration.find(params[:coach_registration_id])
    Coach.create!(name: @registration.fullname, twitter: @registration.twitter, phone_number: @registration.phone_number, email: @registration.email)
    redirect_back(fallback_location: admin_event_path(@registration.event))
  end

  def update
    @registration = CoachRegistration.find(params[:coach_registration_id])
    @coach = Coach.find_by(id: params[:id])
    @registration.coach = @coach
    @registration.save!
    redirect_to(admin_event_path(@registration.event))

  end
end
