class Admin::MeetingsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :set_city
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = @city.meetings
  end

  def show
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end

  def create
    @meeting = @city.meetings.create(meeting_params)

    if @meeting.save
      redirect_to admin_city_meetings_path(@city), notice: 'Meeting was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to admin_city_meetings_path(@city), notice: 'Meeting was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @meeting.destroy
    redirect_to admin_city_meetings_path(@city), notice: 'Meeting was successfully destroyed.'
  end

  private
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def set_city
      @city = City.find_by_slug(params[:city_id])
    end

    def meeting_params
      params.require(:meeting).permit(:name, :date, :city_id, :announced, :meeting_type_id, :coachable)
    end
end
