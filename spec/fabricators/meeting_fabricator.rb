Fabricator(:meeting) do
  date { Date.today+1.week }
  city
  meeting_type { Fabricate(:meeting_type) }
  announced { true }
end

Fabricator(:unannounced_meeting, from: :meeting) do
  announced { false }
end
