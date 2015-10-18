class Admin::CoachesController < ApplicationController
  layout 'admin'

  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  before_action :set_not_coaching, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index
    @coaches = Coach.sorted_by_name
  end

  def show
  end

  def new
    @coach = Coach.new
  end

  def edit
  end

  def create
    @coach = Coach.new(coach_params)

    if @coach.save
      redirect_to [:admin, @coach], notice: 'Coach was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @coach.update(coach_params)
      redirect_to [:admin, @coach], notice: 'Coach was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @coach.destroy
    redirect_to admin_coaches_url, notice: 'Coach was successfully destroyed.'
  end

  private
    def set_coach
      @coach = Coach.find(params[:id])
    end

    def coach_params
      params.require(:coach).permit(:name, :twitter, :email, :phone_number)
    end

    def set_not_coaching
      @not_coaching = Meeting.coachable + Event.coachable - @coach.coachings.map(&:coachable)
    end
end
