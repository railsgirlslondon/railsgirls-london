class RegistrationsController < ApplicationController
  def new
    @city = City.find_by_slug params[:city_id]
    @registration = Registration.new
  end

  def create
    @registration = Registration.new params[:registration]

    if @registration.save
      flash[:notice] = "Thanks for registering!"
      redirect_to city_path(params[:city_id])
    else
      @city = City.find params[:city_id]
      render action: :new
    end
  end
end
