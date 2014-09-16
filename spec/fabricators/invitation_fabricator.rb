Fabricator(:invitation) do
  invitee { Fabricate(:member) }
end

Fabricator(:meeting_invitation, from: :invitation) do
  invitable { Fabricate(:meeting) }
end

Fabricator(:event_invitation, from: :invitation) do
  invitable { Fabricate(:event) }
  invitee { Fabricate(:registration) }
end

Fabricator(:accepted_invitation, from: :invitation) do
  attending  true
end

Fabricator(:waiting_invitation, from: :invitation) do
  waiting_list true
end
