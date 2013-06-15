class Sponsor < ActiveRecord::Base
  ADDRESS_FIELDS = [
    :address_line_1,
    :address_line_2,
    :address_postcode,
    :address_city
  ]

  attr_accessible :name,
                  :description,
                  :primary_contact_email,
                  :image_url,
                  :website,
                  :host,
                  :events,
                  *ADDRESS_FIELDS

  validates :name, :website, presence: true

  validates *ADDRESS_FIELDS, presence: true, if: :is_host?

  has_many :event_sponsorships
  has_many :events, through: :event_sponsorships

  def is_host?
    event_sponsorships.where(host: true).any?
  end

  def is_host_for?(event)
    event_sponsorships.where(event: event, host: true).any?
  end

  def has_full_address?
    ADDRESS_FIELDS.all? do |field|
      self.send(field).present?
    end
  end
end
