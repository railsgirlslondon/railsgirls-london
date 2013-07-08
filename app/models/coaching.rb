class Coaching < ActiveRecord::Base
  belongs_to :coach
  belongs_to :coachable, :polymorphic => true

  attr_accessible :coachable_type, :coachable_id, :coach_id, :coach, :organiser

  validate :coach_must_have_phone, if: :organiser?

  def coach_must_have_phone
    return if coach.phone_number.present? 

    errors.add(:coach, "must have phone number")
  end
end
