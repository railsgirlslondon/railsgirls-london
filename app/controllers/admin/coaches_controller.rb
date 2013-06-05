class Admin::CoachesController < ApplicationController
  layout 'admin'

  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /coaches
  def index
    @coaches = Coach.all
  end

  # GET /coaches/1
  def show
  end

  # GET /coaches/new
  def new
    @coach = Coach.new
  end

  # GET /coaches/1/edit
  def edit
    @event_coachings = @coach.event_coachings
    @not_coached_events = Event.all - @coach.events
  end

  # POST /coaches
  def create
    @coach = Coach.new(coach_params)

    if @coach.save
      redirect_to [:admin, @coach], notice: 'Coach was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /coaches/1
  def update
    if @coach.update(coach_params)
      redirect_to [:admin, @coach], notice: 'Coach was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /coaches/1
  def destroy
    @coach.destroy
    redirect_to admin_coaches_url, notice: 'Coach was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach
      @coach = Coach.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coach_params
      params.require(:coach).permit(:name, :twitter, :email)
    end
end
