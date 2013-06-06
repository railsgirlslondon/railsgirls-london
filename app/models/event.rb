require_lib 'events/geocode_address'

class Event < ActiveRecord::Base
  ATTRIBUTES = [ :description,
                 :city_id,
                 :city,
                 :address,
                 :coordinates,
                 :starts_on,
                 :ends_on,
                 :registration_deadline,
                 :active]

  attr_accessible *ATTRIBUTES

  validates :description, :city_id, :starts_on, :ends_on, presence: true
  validates :active, uniqueness: {scope: :city_id}, if: :active?

  delegate :name, to: :city, prefix: true

  belongs_to :city
  has_many :registrations

  has_many :event_sponsorships
  has_many :sponsors, through: :event_sponsorships

  has_many :event_coachings
  has_many :coaches, through: :event_coachings

  serialize :coordinates, Hash

  def title
    "#{self.starts_on.strftime("%d")}-#{self.ends_on.strftime("%d")} #{self.starts_on.strftime("%B %Y")}"
  end

  def accepting_registrations?
    return false unless registration_deadline.present?
    registration_deadline.future?
  end

  def address=(address)
    super address

    # cache the coordinates of the location for showing on a map
    self.coordinates = Events::GeocodeAddress.to_coordinates(address)
  end

end
