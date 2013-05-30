class Sponsor < ActiveRecord::Base
  attr_accessible :name, :description, :primary_contact_email

  validates :name, presence: true

  has_many :event_sponsorships
  has_many :events, through: :event_sponsorships
end