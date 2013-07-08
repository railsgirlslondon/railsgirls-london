class Coach < ActiveRecord::Base
  attr_accessible :name, :twitter, :email, :phone_number

  has_many :coachings

  validates :name, :email, presence: true

  def is_organiser_for?(object)
    coachings.where(coachable_id: object.id, coachable_type: object.class.to_s.humanize, organiser: true).any?
  end
end
