class City < ActiveRecord::Base
  attr_accessible :name, :twitter
  attr_protected :slug

  before_save :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize
  end
end
