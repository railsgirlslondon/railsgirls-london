class Coaching < ActiveRecord::Base
  belongs_to :coach
  belongs_to :coachable, :polymorphic => true

  attr_accessible :coachable_type, :coachable_id, :coach_id, :coach
end
