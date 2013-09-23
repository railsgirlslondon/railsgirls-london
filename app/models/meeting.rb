class Meeting < ActiveRecord::Base
  ATTRIBUTES = [ :city_id,
                 :city,
                 :date,
                 :meeting_type_id,
                 :meeting_type,
                 :sponsorships,
                 :sponsors,
                 :announced ]

  attr_accessible(*ATTRIBUTES)

  include Extentions::Sponsorable
  include Extentions::Coachable
  include Extentions::Invitable

  validates :meeting_type_id, presence: true

  belongs_to :city
  delegate :name, to: :city, prefix: true

  belongs_to :meeting_type

  scope :upcoming, -> { where("date >= ?", Date.today).order(:date) }
  scope :announced, -> { where("announced = ?", true) }

  delegate :name, to: :meeting_type
  delegate :description, to: :meeting_type
  delegate :active_members, to: :city

  def self.all_sponsors
    Sponsorship.where(:sponsorable_type => "Meeting").map(&:sponsor).uniq! or []
  end

  def to_s
    "<strong>#{self.name}</strong>, #{I18n.l(date, format: :date)}"
  end

  def email email_type, member, invitation
    MeetingMailer.send(email_type.to_sym, self, member, invitation).deliver
  end

  def invite_members
    active_members.each { |member| invite(member) }
  end

end
