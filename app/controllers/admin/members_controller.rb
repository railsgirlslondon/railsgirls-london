class Admin::MembersController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.all
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.create(member_params)

    if @member.save
      redirect_to admin_members_path, admin_notice: 'Member was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @member.update(member_params)
      redirect_to admin_members_path, admin_notice: 'Member was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(Member::PERMITTED_ATTRIBUTES)
    end
end
