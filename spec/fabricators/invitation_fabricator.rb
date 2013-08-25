Fabricator(:invitation) do
  member { Fabricate(:member) }
end

Fabricator(:meeting_invitation, from: :invitation) do
  invitable { Fabricate(:meeting) }
end

Fabricator(:accepted_invitation, from: :invitation) do
  attending  true
end

Fabricator(:waiting_invitation, from: :invitation) do
  waiting_list true
end
