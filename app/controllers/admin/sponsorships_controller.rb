class Admin::SponsorshipsController < ApplicationController
  layout 'admin'

  def create
    sponsorship = Sponsorship.new(sponsor_params)

    if sponsorship.save
      redirect_to edit_admin_sponsor_path(sponsor_params[:sponsor_id])
    else
      flash[:error] = sponsorship.errors.full_messages.join("\n")
      redirect_to edit_admin_sponsor_path(sponsor_params[:sponsor_id])
    end
  end

  def destroy
    sponsorship = Sponsorship.find(params[:id])
    sponsorship.destroy

    redirect_to edit_admin_sponsor_path(sponsorship.sponsor_id)
  end

  def update
    sponsorship = Sponsorship.find(params[:id])

    unless sponsorship.update_attributes(host_params)
      flash[:error] = sponsorship.errors.full_messages.join("\n")
    end

    redirect_to edit_admin_sponsor_path(sponsorship.sponsor)
  end

  private
  def host_params
    params.require(:sponsorship).permit(:host)
  end

  def sponsor_params
    params.require(:sponsorship).permit(:host, :sponsorable_id, :sponsorable_type, :sponsor_id)
  end
end
