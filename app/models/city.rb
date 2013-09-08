class City < ActiveRecord::Base
  attr_accessible :name, :twitter
  attr_protected :slug

  has_many :events
  has_many :meetings
  has_many :members
  has_many :social_media

  has_one :upcoming_event, -> { where("active =  ? and starts_on > ?", true, Date.today) }, class_name: "Event"
  has_many :past_events, -> { where("starts_on <= ?", Date.today) }, class_name: "Event"

  before_save :generate_slug

  def active_members
    members.where(active: true)
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize
  end

  def sponsors
    [events.map(&:sponsors) + meetings.map(&:sponsors)].flatten.uniq
  end
end
