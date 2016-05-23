class SponsorComparator

  def initialize(event)
    @event = event
  end

  def sponsors_for_logos
    Sponsor.all.sort { |a, b|
      a_is_sponsor = event_sponsor?(a)
      b_is_sponsor = event_sponsor?(b)

      if a_is_sponsor == b_is_sponsor
        a.sponsorships.count <=> b.sponsorships.count
      else
        a_is_sponsor ? +1 : -1
      end
    }.reverse
  end

  private

  attr_reader :event

  def event_sponsors
    @event_sponsors ||= (event.present? ? event.sponsors : [])
  end

  def event_sponsor?(sponsor)
    event_sponsors.include?(sponsor)
  end

end
