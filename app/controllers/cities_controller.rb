class CitiesController < ApplicationController
  def show
     @city = City.find_by_id(params[:id])
  end
end
