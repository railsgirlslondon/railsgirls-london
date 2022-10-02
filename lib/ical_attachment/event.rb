module IcalAttachment
  class Event < Base

    alias_method :event, :model

    TYPES_OF_EVENTS = [:friday_installation_party, :saturday_workshop, :saturday_afterparty]

    FRIDAY_START_TIME = '18:30'
    FRIDAY_END_TIME = '21:15'

    SATURDAY_START_TIME = '9:00'
    SATURDAY_END_TIME = '17:00'

    # TODO refactor later
    def friday_installation_party
      add_event(event.starts_on, FRIDAY_START_TIME, FRIDAY_END_TIME, 'Installation Party', 'Installing Ruby on Rails & preparing for the workshop! Pizza & DJ 🍕🎵')
    end

    def saturday_workshop
      add_event(event.ends_on, SATURDAY_START_TIME, SATURDAY_END_TIME, 'Workshop', 'Workshop day 💻 💎')
    end

    def saturday_afterparty
      add_event(event.ends_on, '17:00', '21:00', 'Afterparty', 'Drinks in a local pub (location TBD on the day)')
    end

    def add_event(day, start_time, end_time, title, description)
      ical_event = Icalendar::Event.new

      ical_event.dtstart = day.to_datetime + Time.parse(start_time).seconds_since_midnight.seconds
      ical_event.dtend = day.to_datetime + Time.parse(end_time).seconds_since_midnight.seconds
      ical_event.summary = 'Rails Girls London :: ' + event.title + '\n' + title
      ical_event.description = description + '\n' + event.host.full_address
      ical_event.location = '\n' + event.host.full_address
      cal.add_event(ical_event)
    end
  end
end
