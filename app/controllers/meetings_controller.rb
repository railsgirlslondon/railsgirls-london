class MeetingsController < ApplicationController
  layout 'cities'

  before_action :set_city
  before_action :set_meeting, only: [:show]

  def index
    @meetings = Meeting.where(city: @city).announced
    @sponsors = Meeting.all_sponsors
  end

  def show
    if @meeting.announced?
      @sponsors = @meeting.sponsors
    else
      redirect_to city_meetings_path(@city), notice: 'No such meeting.'
    end
  end

  private

    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def set_city
      @city = City.find_by_slug(params[:city_id])
    end

    def meeting_params
      params.require(:meeting).permit(:name, :date, :announcement_date, :city_id, :meeting_type_id)
    end

    def find_all_sponsors
      @sponsors ||= Meeting.all_sponsors
    end
end
