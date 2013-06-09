class CitiesController < ApplicationController
  layout 'cities'

  def show
    @city = City.find_by_slug(params[:id])
    not_found unless @city
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def sponsor
    @city = City.find_by_slug(params[:city_id])
    render layout: 'application'
  end
end
