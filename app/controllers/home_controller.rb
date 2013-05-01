class HomeController < ApplicationController
  def index
    @cities = HostCity.all
  end
end
