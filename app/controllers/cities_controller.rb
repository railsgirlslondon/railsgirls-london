class CitiesController < ApplicationController
  def show
    @city = City.find_by_slug(params[:id])
  end
end
