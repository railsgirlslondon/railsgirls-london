require 'tempfile'

module IcalAttachment

  autoload :Event, Rails.root.join('lib/ical_attachment/event')
  autoload :Meeting, Rails.root.join('lib/ical_attachment/meeting')

  class Base
    include Icalendar

    attr :model

    def initialize(model)
      @model = model
      @cal = Calendar.new
    end

    def to_temp_file
      Tempfile.new("ical-#{model.class.name}").tap do |f|
        f.write @cal.to_ical
        f.rewind
      end
    end

  end
end
