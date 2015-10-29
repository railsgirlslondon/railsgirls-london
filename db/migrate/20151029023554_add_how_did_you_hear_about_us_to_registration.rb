class AddHowDidYouHearAboutUsToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :how_did_you_hear_about_us, :text
  end
end
