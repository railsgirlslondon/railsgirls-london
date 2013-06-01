class Sponsor < ActiveRecord::Base
  attr_accessible :name, :description, :primary_contact_email, :image_url, :website

  validates :name, :website, presence: true

  has_many :event_sponsorships
  has_many :events, through: :event_sponsorships
end
