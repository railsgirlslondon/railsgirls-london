class HostCity < ActiveRecord::Base
  attr_accessible :description, :name, :slug

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true
end
