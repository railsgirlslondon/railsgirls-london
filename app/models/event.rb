class Event < ActiveRecord::Base

  ATTRIBUTES = [
    :title,
    :description,
    :starts_on,
    :ends_on,
    :image,
    :registration_deadline,
    :active,
    :accepting_feedback
  ]

  # attr_accessible *ATTRIBUTES

  include Extentions::Sponsorable
  include Extentions::Coachable
  include Extentions::Invitable

  validates :starts_on, :ends_on, presence: true

  has_many :registrations
  has_many :coach_registrations
  has_many :feedbacks

  default_scope { order('events.created_at DESC') }

  scope :upcoming, -> { where("ends_on >= ? and active = ?", Date.today, true).reorder(:starts_on) }
  scope :past, -> { where("ends_on <= ? and active = ?", Date.today, false).reorder(:starts_on) }

  def self.next_event
    Event.upcoming.first
  end

  def accepting_registrations?
    ends_on > Date.today
  end

  def registrations_open?
    accepting_registrations? and Date.today <= registration_deadline
  end

  def accepting_feedback?
    accepting_feedback
  end

  def rsvps_available?
    rsvp_end_date >= Date.today
  end

  def rsvp_end_date
    starts_on-2.days
  end

  def early_bird_available?
    registration_deadline_early_bird >= Date.today
  end

  def start_date
    format_date(starts_on)
  end

  def end_date
    format_date(ends_on)
  end

  def dates
    return format_date(starts_on) if starts_on.eql? ends_on
    dates = day(starts_on)
    dates << month(starts_on) unless starts_on.month.eql? ends_on.month
    dates << until_day_month_and_year(ends_on)
  end

  def email email_type, registration, invitation
    EventMailer.send(email_type.to_sym, self, registration, invitation).deliver_now
  end

  def invite_members
    selected_applicants.each { |member| invite(member) }
  end

  def invite_again(invitation)
    EventMailer.send(:invite, self, invitation.invitee, invitation).deliver_now
  end

  def send_reminder(invitation)
    EventMailer.send(:invitation_reminder, self, invitation.invitee, invitation).deliver_now
  end

  def send_welcome(invitation)
    EventMailer.send(:welcome_message, self, invitation.invitee).deliver_now
  end

  def send_reminders
    attending_students.each {|student| send_welcome(student.invitation) }
  end

  def welcome_coaches
    coaches.each {|coach| welcome(coach) }
  end

  def welcome(coach)
    EventMailer.send(:welcome_coaches, self, coach).deliver_now
  end

  def attending_students
    selected_applicants.joins(:invitation).where(invitations: { attending: true} )
  end

  def selected_applicants
    registrations.where :selection_state => "accepted"
  end

  def send_post_event_feedback
    all_attendees.each {|participant| post_event_feedback(participant) }
  end

  def all_attendees
    attending_students + coaches
  end

  def post_event_feedback(participant)
    EventMailer.send(:ask_for_feedback, self, participant).deliver_now
  end

  def attendees
    (selected_applicants + coachings).sort_by(&:name)
  end

  def attended_students
    selected_applicants.where(attended: :attended)
  end

  def instruct_coaches
    coaches.each {|coach| instruct(coach)}
  end

  def instruct coach
    EventMailer.send(:coaches_instruction, self, coach).deliver_now
  end

  def weeklies_invitees
    registrations.where :selection_state => "RGL Weeklies"
  end

  def ask_for_feedback
    attended_students.each { |registration|
      EventMailer.send(:ask_for_feedback, self, registration).deliver_now
    }
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
