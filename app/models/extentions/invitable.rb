require 'active_support/concern'

module Extentions
  module Invitable

    extend ActiveSupport::Concern

    included do
      include InstanceMethods

      has_many :invitations, as: :invitable

      attr_accessible :available_slots

    end
  end

  module InstanceMethods

    def invite member
      invitations.create member: member
    end

    def invite_members
      active_members.each { |member| invite(member) }
    end

    def has_available_slots?
      available_slots and available_slots > invitations.accepted.count
    end

    def process_waiting_list
      spots = available_slots - invitations.accepted.count
      invitations.waiting_list.limit(spots).each do |invitation|
        invitation.update_attributes(attending: true, waiting_list: false)
      end
    end
  end
end
