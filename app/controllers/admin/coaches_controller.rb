class Admin::CoachesController < ApplicationController
  layout 'admin'

  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :find_cities

  def index
    @coaches = Coach.all
  end

  def show
  end

  def new
    @coach = Coach.new
  end

  def edit
    @not_coaching = non_coached(@coach)
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
      params.require(:coach).permit(:name, :twitter, :email)
    end

    def non_coached coach
      Meeting.coachable + Event.coachable - coach.coachings.map(&:coachable)
    end
end
