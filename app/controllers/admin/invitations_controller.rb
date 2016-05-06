class Admin::InvitationsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def create
    Event.find(params[:event_id]).invite_members

    redirect_to :back
  end

  def show
    @invitation = Invitation.find_by_token params[:id]
  end

end
