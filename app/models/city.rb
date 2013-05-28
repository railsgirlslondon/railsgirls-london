class City < ActiveRecord::Base
  attr_accessible :name, :twitter
  attr_protected :slug

  has_many :events
  has_one :upcoming_event, conditions: { active:  true}, class_name: "Event"

  before_save :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize
  end
end
