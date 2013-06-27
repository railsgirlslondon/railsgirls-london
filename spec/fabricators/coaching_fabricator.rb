Fabricator(:coaching) do
  coach { Fabricate(:coach) }
end

Fabricator(:event_coaching, from: :coaching) do
  coachable_type { 'Event' }
  coachable_id { Fabricate(:event).id }
end
