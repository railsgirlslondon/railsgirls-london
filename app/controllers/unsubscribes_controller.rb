class UnsubscribesController < ApplicationController
  def new
    @member_uuid = params[:member_uuid]
  end

  def create
    Member.deactivate!(params[:member_uuid])

    redirect_to root_path, notice: "Thanks for your participation.\nPlease post on the mailing lists if you'd like to rejoin RailsGirls London"
  end
end
