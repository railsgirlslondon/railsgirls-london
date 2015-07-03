class Event < ActiveRecord::Base
  ATTRIBUTES = [
    :title,
    :description,
    :city_id,
    :city,
    :starts_on,
    :ends_on,
    :image,
    :registration_deadline,
    :active
  ]

  attr_accessible *ATTRIBUTES

  include Extentions::Sponsorable
  include Extentions::Coachable
  include Extentions::Invitable

  validates :description, :city_id, :starts_on, :ends_on, presence: true
  validates :active,      uniqueness: {scope: :city_id}, if: :active?

  delegate :name, to: :city, prefix: true

  belongs_to :city
  has_many :registrations

  default_scope { order('events.created_at DESC') }

  scope :upcoming, -> { where("ends_on >= ? and active = ?", Date.today, true).order(:starts_on) }

  def accepting_registrations?
    registration_deadline.present?
  end

  def registrations_open?
    accepting_registrations? and Date.today <= registration_deadline
  end

  def rsvps_available?
    rsvp_end_date >= Date.today
  end

  def rsvp_end_date
    starts_on-5.days
  end

  def dates
    return format_date(starts_on) if starts_on.eql? ends_on
    dates = day(starts_on)
    dates << month(starts_on) unless starts_on.month.eql? ends_on.month
    dates << until_day_month_and_year(ends_on)
  end

  def export_applications_to_trello
    trello.export "Applications"
  end

  def process_applications slots=35
    application_manager = ApplicationManager.new(self, slots)
    application_manager.process!
  end

  def email email_type, registration, invitation
    EventMailer.send(email_type.to_sym, self, registration, invitation).deliver_now
  end

  def invite_members
    selected_applicants.each { |member| invite(member) }
  end

  def selected_applicants
    registrations.where selection_state: "accepted"
  end

  def waiting_list_applicants
    registrations.where selection_state: "waiting list"
  end

  def weeklies_invitees
    registrations.where selection_state: "RGL Weeklies"
  end

  def trello
    @trello ||= EventTrello.new(self)
  end

  def to_s
    "<strong>Workshop</strong>, #{self.dates}"
  end

  def members_converted?
    return true if registrations.empty? or registrations.members.count == registrations.count
    false
  end

  def convert_attendees_to_members!
    return registrations.accepted.map do |registration|
      Member.create_from_registration(registration)
    end
  end

  private

  def format_date(date)
    date.strftime("%B %-d, %Y")
  end

  def day date
    date.strftime("%-d")
  end

  def month date
    date.strftime(" %B")
  end

  def until_day_month_and_year date
    date.strftime("-%-d %B %Y")
  end
end
