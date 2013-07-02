Fabricator(:invitation) do
  member { Fabricate(:member) }
end

Fabricator(:meeting_invitation, from: :invitation) do
  invitable { Fabricate(:meeting) }
end
