class Admin::CitiesController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!

  def new

  end

  def create
    City.create! params[:city]
    redirect_to admin_cities_path
  end

  def index
    @cities = City.all
  end
end
