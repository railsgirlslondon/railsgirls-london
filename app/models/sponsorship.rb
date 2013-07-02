class Sponsorship < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :sponsorable, :polymorphic => true

  attr_accessible :sponsorable_type, :sponsorable_id, :sponsor_id, :host, :sponsor, :sponsorable

  validate :host_must_have_address, if: :host?
  validate :host_must_be_unique, if: :host?

  def host_must_have_address
    return if sponsor.has_full_address?

    errors.add(:host, "must have full address")
  end

  def host_must_be_unique
    return unless sponsorable.has_host?

    errors.add(:host, "already exists")
  end
end
