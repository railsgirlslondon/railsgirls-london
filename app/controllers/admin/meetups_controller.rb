class Admin::MeetupsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def index
    @meetups = Meetup.all
  end

  def new
    @meetup = Meetup.new
  end

  def show
    @meetup = Meetup.find(params[:id])
  end

  def edit
    @meetup = Meetup.find(params[:id])
  end

  def create
    @meetup = Meetup.new(meetup_params)
    if @meetup.save
      redirect_to [:admin, @meetup], notice: "meetup created"
    else
      redirect_to :back
    end
  end

  def update
    @meetup = Meetup.find(params[:id])
    if @meetup.update_attributes(meetup_params)
      redirect_to [:admin, @meetup], notice: "meetup updated"
    else
      redirect_to :back
    end
  end

  def destroy
  end

  private

  def meetup_params
    params.require(:meetup).permit(:title, :description, :starts_on, :image, :available_slots, :address, :postcode, :location_name, :location_website, :short_blurb)
  end

end
