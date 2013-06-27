class Admin::CitiesController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_cities

  def new
  end

  def create
    City.create! params[:city]
    redirect_to admin_cities_path
  end

  def index
    @cities = City.all
  end

  def show
    @city = City.find_by_slug params[:id]
  end
end
