class EventSponsorship < ActiveRecord::Base
  attr_accessible :event_id, :sponsor_id, :event, :sponsor, :host
  belongs_to :event
  belongs_to :sponsor

  validate :host_must_have_address, if: :host?

  def host_must_have_address
    return if sponsor.has_full_address?

    errors.add(:host, "must have full address")
  end
end