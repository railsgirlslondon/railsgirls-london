class SponsorComparator

  def initialize(event)
    @event = event
  end

  def sponsors_for_logos
    Sponsor.all.sort { |a, b|
      a_is_sponsor = current_event_sponsor?(a)
      b_is_sponsor = current_event_sponsor?(b)

      if a_is_sponsor == b_is_sponsor
        sort_sponsors_by_relevance(a, b)
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

  def current_event_sponsor?(sponsor)
    event_sponsors.include?(sponsor)
  end

  def sort_sponsors_by_relevance(a, b)
    if (a.sponsorships.count <=> b.sponsorships.count) == 0
      a.sponsorships.most_recent.created_at <=> b.sponsorships.most_recent.created_at
    else
      a.sponsorships.count <=> b.sponsorships.count
    end
  end

end
