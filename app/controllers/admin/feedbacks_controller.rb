class Admin::FeedbacksController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_cities, :set_city

  def index
    @feedbacks = @city.feedbacks.all
  end

  def show
    @feedback = Feedback.find params[:id]
  end

  private

  def set_city
    @city = City.find_by_slug(params[:city_id])
  end
end
