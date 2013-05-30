class EventCoaching < ActiveRecord::Base
  attr_accessible :event_id, :coach_id
  belongs_to :event
  belongs_to :coach
end