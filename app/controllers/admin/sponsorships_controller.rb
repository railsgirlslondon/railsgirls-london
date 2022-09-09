class Admin::SponsorshipsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def create
    sponsorship = Sponsorship.new(sponsor_params)

    if sponsorship.save
      flash[:notice] = "#{sponsorship.sponsor.name} sponsorship has been added to #{sponsorship.sponsorable.to_s}.".html_safe
      redirect_back(fallback_location: admin_sponsors_url)
    else
      flash[:error] = sponsorship.errors.full_messages.join("\n")
      redirect_back(fallback_location: admin_sponsors_url, notice: flash[:error])
    end
  end

  def destroy
    sponsorship = Sponsorship.find(params[:id])
    sponsorship.destroy

    flash[:notice] = "#{sponsorship.sponsor.name} sponsorship has been removed from #{sponsorship.sponsorable.to_s}.".html_safe

    redirect_back(fallback_location: admin_sponsors_url)
  end

  def update
    sponsorship = Sponsorship.find(params[:id])

    if sponsorship.update(host_params)
      flash[:notice] = "#{sponsorship.sponsor.name} sponsorship has been updated.".html_safe
    else
      flash[:error] = sponsorship.errors.full_messages.join("\n")
    end

    redirect_to(:back)
  end

  private
  def host_params
    params.require(:sponsorship).permit(:host)
  end

  def sponsor_params
    params.require(:sponsorship).permit(:host, :sponsorable_id, :sponsorable_type, :sponsor_id)
  end
end
