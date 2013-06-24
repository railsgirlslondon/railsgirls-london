class Coach < ActiveRecord::Base
  attr_accessible :name, :twitter, :email

  has_many :coachings
end
