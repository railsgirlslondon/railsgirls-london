class CitiesController < ApplicationController
  layout 'cities'

  def show
    @city = City.find_by_slug(params[:id])
  end

  def sponsor
    @city = City.find_by_slug(params[:city_id])
    render layout: 'application'
  end
end
