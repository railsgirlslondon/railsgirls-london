class RegistrationsController < ApplicationController
  def new
    @city = City.find params[:city_id]
    @registration = Registration.new
  end

  def create
    @registration = Registration.new params[:registration]

    if @registration.save
      flash[:notice] = "Thanks for registering!"
      redirect_to root_path
    else
      @city = City.find params[:city_id]
      render action: :new
    end
  end
end