class Event < ActiveRecord::Base
  ATTRIBUTES = [ :description,
                 :city_id,
                 :city,
                 :starts_on,
                 :ends_on,
                 :registration_ends_on,
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

  def title
    "#{self.starts_on.strftime("%d")}-#{self.ends_on.strftime("%d")} #{self.starts_on.strftime("%B %Y")}"
  end

end
