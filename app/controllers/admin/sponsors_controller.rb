class Admin::SponsorsController < ApplicationController
  before_action :set_sponsor, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /sponsors
  def index
    @sponsors = Sponsor.all
  end

  # GET /sponsors/1
  def show
  end

  # GET /sponsors/new
  def new
    @sponsor = Sponsor.new
  end

  # GET /sponsors/1/edit
  def edit
    @event_sponsorships = @sponsor.event_sponsorships
    @not_sponsored_events = Event.all - @sponsor.events
  end

  # POST /sponsors
  def create
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      redirect_to [:admin, @sponsor], notice: 'Sponsor was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /sponsors/1
  def update
    if @sponsor.update(sponsor_params)
      redirect_to [:admin, @sponsor], notice: 'Sponsor was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /sponsors/1
  def destroy
    @sponsor.destroy
    redirect_to admin_sponsors_url, notice: 'Sponsor was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsor
      @sponsor = Sponsor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sponsor_params
      params.require(:sponsor).permit(:name, :description, :primary_contact_email, :image_url, :website)
    end
end
