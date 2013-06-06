class Admin::EventSponsorshipsController < ApplicationController
  layout 'admin'

  def create
    EventSponsorship.create!(events_sponsor_params)
    redirect_to edit_admin_sponsor_path(events_sponsor_params[:sponsor_id])
  end

  def destroy
    EventSponsorship.find(params[:id]).destroy
    redirect_to edit_admin_sponsor_path(params[:sponsor_id])
  end

  def update
    event_sponsorship = EventSponsorship.find(params[:id])
    event_sponsorship.update_attributes!(host_params)
    redirect_to edit_admin_sponsor_path(event_sponsorship.sponsor)
  end

  private
    def host_params
      params.require(:event_sponsorship).permit(:host)
    end

    def events_sponsor_params
      params.require(:event_sponsorship).permit(:event_id, :sponsor_id)
    end
end
