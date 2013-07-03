class InvitationsController < ApplicationController
  before_action :set_city

  def show
    @invitation = Invitation.find params[:id]
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
