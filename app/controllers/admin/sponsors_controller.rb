class Admin::SponsorsController < ApplicationController
  WHITE_LIST = [:name,
                :description,
                :primary_contact_email,
                :image_url,
                :sponsorable_id,
                :sponsoraable_type,
                :website,
                :address_line_1,
                :address_line_2,
                :address_city,
                :address_postcode,
                :host]

  layout 'admin'

  before_action :set_sponsor, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @sponsors = Sponsor.all
  end

  def show
  end

  def new
    @sponsor = Sponsor.new
  end

  def edit
    @sponsorships = @sponsor.sponsorships
    @non_sponsored = Meeting.all + Event.all - @sponsorships.map(&:sponsorable)
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      redirect_to [:admin, @sponsor], notice: 'Sponsor was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @sponsor.update(sponsor_params)
      redirect_to [:admin, @sponsor], notice: 'Sponsor was successfully updated.'
    else
      @sponsorships = @sponsor.sponsorships
      @non_sponsored = Meeting.all + Event.all - @sponsorships.map(&:sponsorable)
      render action: 'edit'
    end
  end

  def destroy
    @sponsor.destroy
    redirect_to admin_sponsors_url, notice: 'Sponsor was successfully destroyed.'
  end

  private
  def set_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def sponsor_params
    params.require(:sponsor).permit(WHITE_LIST)
  end
end
