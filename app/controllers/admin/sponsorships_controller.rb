class Admin::SponsorshipsController < ApplicationController
  layout 'admin'

  def create
    sponsorship = Sponsorship.new(sponsor_params)

    if sponsorship.save
      flash[:notice] = "#{sponsorship.sponsor.name} sponsorship has been added to #{sponsorship.sponsorable.to_s}.".html_safe
    else
      flash[:error] = sponsorship.errors.full_messages.join("\n")
    end

    redirect_to(:back)
  end

  def destroy
    sponsorship = Sponsorship.find(params[:id])
    sponsorship.destroy

    flash[:notice] = "#{sponsorship.sponsor.name} sponsorship has been removed from #{sponsorship.sponsorable.to_s}.".html_safe

    redirect_to(:back)
  end

  def update
    sponsorship = Sponsorship.find(params[:id])

    if sponsorship.update_attributes(host_params)
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
