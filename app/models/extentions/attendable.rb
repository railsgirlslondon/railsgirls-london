require 'active_support/concern'

# Both students & coaches at an event can have their attendance tracked (ie. whether they showed up or not,
# along with a note). The fields are the same in both places, so this is extracted out into a concern.
module Extentions
  module Attendable

    extend ActiveSupport::Concern

    included do
      enum attended: [:unknown, :attended, :cancelled, :no_show]
      # attr_accessible :attended, :attendance_note
    end
  end
end
