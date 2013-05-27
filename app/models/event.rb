class Event < ActiveRecord::Base
  attr_accessible :description, :city_id, :active

  validates :city, :description, presence: true
  validates :active, uniqueness: {scope: :city_id}, if: :active?

  delegate :name, to: :city, prefix: true

  belongs_to :city

  has_many :registrations

end
