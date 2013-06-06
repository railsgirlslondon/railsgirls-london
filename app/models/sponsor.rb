class Sponsor < ActiveRecord::Base
  attr_accessible :name, 
                  :description, 
                  :primary_contact_email, 
                  :image_url, 
                  :website,
                  :address_line_1,
                  :address_line_2,
                  :address_postcode,
                  :address_city

  validates :name, :website, presence: true
  
  validates :address_line_1,
            :address_line_2, 
            :address_postcode, 
            :address_city, 
            presence: true, if: :host?

  has_many :event_sponsorships
  has_many :events, through: :event_sponsorships
end
