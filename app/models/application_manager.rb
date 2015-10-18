class ApplicationManager

  WEEKLIES_LABEL="purple"

  attr_reader :event, :spots, :weeklies, :applications, :accepted, :waiting

  def initialize(event, spots=35)
    @event = event
    @spots = spots
  end

  def process!
    # mark_applications
  end

  private

  def mark_applications
    mark_registrations_as "accepted", accepted
    mark_registrations_as "waiting list", waiting if waiting
    mark_registrations_as "RGL Weeklies", weeklies.cards if weeklies
  end

  # def applications
  #   @applications ||= event_trello.applications
  # end
  #
  # def accepted
  #   @accepted ||= applications.take(spots)
  # end
  #
  # def waiting
  #   @waiting  ||= applications.drop(spots)
  # end

  def mark_registrations_as(state, cards)
    @event.registrations.each do |reg|
      reg.mark_selection(state) if event_trello.matches_any_card?(cards, reg.reason_for_applying)
    end
  end
end
