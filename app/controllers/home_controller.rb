class HomeController < ApplicationController
  def index
    @cities = City.all

    redirect_to @cities.first if @cities.length == 1
  end
end
