class Meeting < ActiveRecord::Base
  ATTRIBUTES = [ :city_id,
                 :city,
                 :date,
                 :meeting_type_id,
                 :meeting_type,
                 :announced ]

  attr_accessible *ATTRIBUTES

  include Extentions::Sponsorable
  include Extentions::Coachable

  validates :meeting_type_id, presence: true

  belongs_to :city
  delegate :name, to: :city, prefix: true

  belongs_to :meeting_type

  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :announced, -> { where("announced = ?", true) }

  delegate :name, to: :meeting_type
  delegate :description, to: :meeting_type


  def announce!
    Registration.members.each do |member|
      MeetingMailer.invite(self, member).deliver
    end
  end

  def self.all_sponsors
    Sponsorship.where(:sponsorable_type => "Meeting").map(&:sponsor).uniq! or []
  end
end
