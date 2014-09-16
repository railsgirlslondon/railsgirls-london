class Admin::InvitationsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :find_cities, :set_city

  def create
    invitable.invite_members

    redirect_to :back
  end

  def show
    @invitation = Invitation.find_by_token params[:id]
    @feedback = @invitation.feedback
  end

  private

  def invitable
    id = params[:invitable_id]
    klass = "::#{params[:invitable_type]}".constantize rescue nil

    klass ? klass.find(params[id].to_i) : nil
  end

  def set_city
    @city = City.find_by_slug(params[:city_id])
  end
end
