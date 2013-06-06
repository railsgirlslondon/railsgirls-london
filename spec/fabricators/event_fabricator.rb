Fabricator(:event) do
  description { Faker::Lorem.paragraph }
  city
  starts_on { Date.today+1.month }
  ends_on { Date.today+1.month+1.day }
  registration_deadline { Date.today+1.week }
  active true
end

Fabricator(:inactive_event, from: :event) do
  starts_on { Date.today-1.month }
  active false
end

