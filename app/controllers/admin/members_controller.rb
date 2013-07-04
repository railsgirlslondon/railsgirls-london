class Admin::MembersController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :set_city, :find_cities
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = @city.members
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = @city.members.create(member_params)

    if @member.save
      redirect_to admin_city_members_path(@city), notice: 'Member was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @member.update(member_params)
      redirect_to admin_city_members_path(@city), notice: 'Member was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def set_city
      @city = City.find_by_slug(params[:city_id])
    end

    def member_params
      params.require(:member).permit(Member::PERMITTED_ATTRIBUTES)
    end
end
