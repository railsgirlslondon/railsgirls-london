class Coach < ActiveRecord::Base
  attr_accessible :name, :twitter, :email

  has_many :event_coachings
  has_many :events, through: :event_coachings
end
