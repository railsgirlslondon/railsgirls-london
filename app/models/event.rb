class Event < ActiveRecord::Base
  attr_accessible :description, :city_id, :active
  belongs_to :city

  validates :city, :description, presence: true

  delegate :name, to: :city, prefix: true
end