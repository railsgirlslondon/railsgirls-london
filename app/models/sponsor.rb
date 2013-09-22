class Sponsor < ActiveRecord::Base
  MANDATORY_ADDRESS_FIELDS = [
    :address_line_1,
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
                  :map_url,
                  :address_line_2,
                  *MANDATORY_ADDRESS_FIELDS

  validates :name, :website, :presence => true

  validates *MANDATORY_ADDRESS_FIELDS, :presence => true, :if => :is_host?

  has_many :sponsorships

  with_options :through => :sponsorships, :source => :sponsorable do |tag|
    tag.has_many :meetings, :source_type => 'Meeting'
    tag.has_many :events, :source_type => 'Event'
  end

  def is_host?
    sponsorships.where(host: true).any?
  end

  def is_host_for?(object)
    sponsorships.where(sponsorable_id: object.id, sponsorable_type: object.class.to_s.humanize, host: true).any?
  end

  def has_full_address?
    MANDATORY_ADDRESS_FIELDS.all? do |field|
      self.send(field).present?
    end
  end
end
