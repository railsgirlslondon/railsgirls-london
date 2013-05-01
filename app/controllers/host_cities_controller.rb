class HostCitiesController < ApplicationController

  def index
    @host_cities = HostCity.all

    respond_to do |format|
      format.html
      format.json { render json: @host_cities }
    end
  end

  def show
    @host_city = HostCity.find_by_slug(params[:slug])

    respond_to do |format|
      format.html
      format.json { render json: @host_city }
    end
  end

end