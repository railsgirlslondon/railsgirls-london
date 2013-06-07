class Event < ActiveRecord::Base
  ATTRIBUTES = [ :description,
                 :city_id,
                 :city,
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

  delegate :address_line_1, :address_line_2, :address_postcode, :address_city, to: :host
  delegate :name, to: :host, prefix: true

  def title
    "#{self.starts_on.strftime("%d")}-#{self.ends_on.strftime("%d")} #{self.starts_on.strftime("%B %Y")}"
  end

  def accepting_registrations?
    return false unless registration_deadline.present?
    registration_deadline.future?
  end

  def host
    event_sponsorship = event_sponsorships.where(host: true).first

    event_sponsorship.present? and return event_sponsorship.sponsor
  end

  def non_hosting_sponsors
    sponsors - [host]
  end

  def has_host?
    host.present?
  end
end
