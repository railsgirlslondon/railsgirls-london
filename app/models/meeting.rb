class Meeting < ActiveRecord::Base
  ATTRIBUTES = [ :city_id,
                 :city,
                 :date,
                 :meeting_type_id,
                 :meeting_type,
                 :announced ]

  attr_accessible *ATTRIBUTES

  validates :meeting_type_id, presence: true

  belongs_to :city
  belongs_to :meeting_type

  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :announced, -> { where("announced = ?", true) }

  delegate :name, to: :meeting_type
  delegate :description, to: :meeting_type

end
