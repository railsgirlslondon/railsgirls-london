class Admin::CitiesController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_cities
  before_action :find_city, only: [:show]

  def new
    @city = City.new
  end

  def create
    City.create! params[:city]
    redirect_to admin_cities_path
  end

  def index
    @cities = City.all
  end

  def show
  end

  private

  def find_city
    @city = City.find_by_slug params[:id]
  end
end
