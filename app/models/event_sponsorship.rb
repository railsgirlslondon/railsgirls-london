class EventSponsorship < ActiveRecord::Base
  attr_accessible :event_id, :sponsor_id
  belongs_to :event
  belongs_to :sponsor
end