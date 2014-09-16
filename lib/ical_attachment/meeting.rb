module IcalAttachment
  class Meeting < Base

    alias_method :meeting, :model

    def to_event
      cal.event do
        dtstart meeting.date
        summary meeting.name
        description meeting.description
      end
    end
  end
end
