class Admin::EventSponsorshipsController < ApplicationController
  def create
    EventSponsorship.create!(events_sponsor_params)
    redirect_to edit_admin_sponsor_path(events_sponsor_params[:sponsor_id])
  end

  def destroy
    EventSponsorship.find(params[:id]).destroy
    redirect_to edit_admin_sponsor_path(params[:sponsor_id])
  end

  private
    def events_sponsor_params
      params.require(:event_sponsorship).permit(:event_id, :sponsor_id)
    end
end