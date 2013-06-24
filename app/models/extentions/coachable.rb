module Extentions
  module Coachable

    def self.included base
      base.class_eval do

        has_many :coachings, as: :coachable
        has_many :coaches, through: :coachings
      end
    end
  end
end
