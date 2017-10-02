class Meetup < ActiveRecord::Base
  include Extentions::Sponsorable

  default_scope { order('created_at DESC') }
  scope :upcoming, -> { where("starts_on >= ?", Date.today) }

  def dates
    format_date(starts_on)
  end

  def address_postcode
    "#{address}, #{postcode}"
  end

  def format_date(date)
    date.strftime("%B %-d, %Y")
  end

  def to_s
    "<strong>Meetup</strong>, #{self.dates}"
  end

end
