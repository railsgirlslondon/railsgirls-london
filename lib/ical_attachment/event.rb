module IcalAttachment
  class Event < Base

    alias_method :event, :model

    def to_event
      cal.event do
        dtstart event.starts_on
        dtend event.ends_on
        summary event.title
        description event.description
      end
    end
  end
end
