require 'active_support/concern'

module Extentions
  module Coachable

    extend ActiveSupport::Concern

    included do
      attr_accessible :coachable

      has_many :coachings, as: :coachable
      has_many :coaches, through: :coachings

      has_many :organisers, -> { where :"coachings.organiser" => true }, through: :coachings, source: :coach

      scope :coachable, -> { where("coachable = ?", true) }

    end
  end
end
