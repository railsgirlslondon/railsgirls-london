module InvitationHelper

  def invitable_name invitation
    return invitation.invitable.name if invitation.invitable.respond_to? :name
    invitation.invitable.title
  end

  def invitable_date invitation
    return I18n.l(invitation.invitable.date) if invitation.invitable.respond_to? :date
    invitation.invitable.dates
  end
end
