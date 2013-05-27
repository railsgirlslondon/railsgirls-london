class Event < ActiveRecord::Base
  ATTRIBUTES = [ :description,
                 :city_id,
                 :starts_on,
                 :ends_on,
                 :active]

  attr_accessible *ATTRIBUTES

  validates :description, :city_id, presence: true
  validates :active, uniqueness: {scope: :city_id}, if: :active?

  delegate :name, to: :city, prefix: true

  belongs_to :city
  has_many :registrations

end