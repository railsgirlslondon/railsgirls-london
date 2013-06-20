class MeetingType < ActiveRecord::Base
  ATTRIBUTES = [ :name,
                 :description,
                 :frequency]

  attr_accessible *ATTRIBUTES

  has_many :meetings

end
