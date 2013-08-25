class Coach < ActiveRecord::Base
  attr_accessible :name, :twitter, :email, :phone_number

  has_many :coachings

  validates :name, :email, presence: true
  validates :phone_number, :presence => true, :if => :is_organiser?

  def self.sorted_by_name
    all.sort do |coach_a, coach_b|
      coach_a.name.split(' ').last <=> coach_b.name.split(' ').last
    end
  end

  def is_organiser?
    coachings.where(organiser: true).any?
  end

  def is_organiser_for?(object)
    coachings.where(coachable_id: object.id, coachable_type: object.class.to_s.humanize, organiser: true).any?
  end
end
