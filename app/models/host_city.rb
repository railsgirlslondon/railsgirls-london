class HostCity < ActiveRecord::Base
  attr_accessible :description, :name, :slug, :twitter

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  validate :validate_twitter_username

  has_many :events

  def validate_twitter_username
    errors.add(:twitter, "It must begin with @") if twitter and !twitter.starts_with? "@"
  end
end
