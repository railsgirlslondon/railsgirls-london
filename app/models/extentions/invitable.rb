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
      members.each { |member| invite(member) }
    end
  end
end
