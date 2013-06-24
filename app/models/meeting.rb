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

  has_many :sponsorships, as: :sponsorable
  has_many :sponsors, through: :sponsorships

  def non_hosting_sponsors
    sponsors - [host]
  end

  def has_host?
    host.present?
  end

  def host
    sponsorships.where(host: true).try(:first).try(:sponsor)
  end
end
