class Admin::InvitationsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def create
    invitable.invite_members

    redirect_to :back
  end

  def resend_invite
    invitation = Invitation.find(params[:id])
    invitable.invite_again(invitation)
    redirect_to :back
  end

  def show
    @invitation = Invitation.find_by_token params[:id]
  end

  private

  def invitable
    id = params[:invitable_id]
    klass = "::#{params[:invitable_type]}".constantize rescue nil

    klass ? klass.find(params[id].to_i) : nil
  end

end
