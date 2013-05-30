class Sponsor < ActiveRecord::Base
  attr_accessible :name, :description, :primary_contact_email

  validates :name, presence: true
end