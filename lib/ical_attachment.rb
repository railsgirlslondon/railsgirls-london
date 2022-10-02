require 'tempfile'

module IcalAttachment

  autoload :Event, Rails.root.join('lib/ical_attachment/event')

  class Base
    include Icalendar

    attr_reader :model, :cal

    def initialize(model)
      @model = model
      @cal = Calendar.new
    end

    def to_temp_file
      to_event
      Tempfile.new("ical-#{model.class.name}").tap do |f|
        f.write @cal.to_ical
        f.rewind
      end
    end

  end
end
