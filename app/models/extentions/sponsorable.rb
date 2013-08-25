require 'active_support/concern'
module Extentions
  module Sponsorable

    extend ActiveSupport::Concern

    included do
      include InstanceMethods

      has_many :sponsorships, as: :sponsorable
      has_many :sponsors, through: :sponsorships

      delegate :address_line_1, :address_line_2, :address_postcode, :address_city, to: :host
      delegate :name, :website, :image_url, :description, to: :host, prefix: true
    end

    module InstanceMethods
      def non_hosting_sponsors
        sponsors - [host]
      end

      def host
        sponsorships.where(host: true).try(:first).try(:sponsor)
      end

      def has_host?
        host.present?
      end
    end
  end
end
