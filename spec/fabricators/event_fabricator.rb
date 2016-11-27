Fabricator(:event) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.paragraph }
  starts_on { Date.today+1.month }
  ends_on { Date.today+1.month+1.day }
  registration_deadline { Date.today+1.week }
  active true
end

Fabricator(:event_with_sponsor, from: :event) do
  sponsors { Fabricate(:sponsor)}
end

Fabricator(:inactive_event, from: :event) do
  starts_on { Date.today-1.month }
  ends_on { Date.tomorrow-1.month }
  active false
end
