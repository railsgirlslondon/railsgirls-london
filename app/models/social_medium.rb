class SocialMedium < ActiveRecord::Base
  SUPPORTED = %w{ gplus facebook github }

  attr_accessible :name, :url, :city

  belongs_to :city

  validates :name, presence: true,
                   uniqueness: {scope:  [ :city ] }
  validates :url, presence: true
  validate :is_name_valid?

  private

  def is_name_valid?
    unless SocialMedium::SUPPORTED.include? self.name
      errors.add(:name, 'Only gplus, facebook and github are currently supported.')
    end
  end
end
