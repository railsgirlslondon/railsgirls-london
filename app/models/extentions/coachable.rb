module Extentions
  module Coachable

    def self.included base
      base.class_eval do

        attr_accessible :coachable

        has_many :coachings, as: :coachable
        has_many :coaches, through: :coachings

        scope :coachable, -> { where("coachable = ?", true) }
      end
    end
  end
end
