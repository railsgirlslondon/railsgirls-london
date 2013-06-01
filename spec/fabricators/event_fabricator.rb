Fabricator(:event) do
  description { Faker::Lorem.paragraph }
  city
  starts_on { Date.today+1.month }
  ends_on { Date.today+1.month+1.day }
  active true
end

Fabricator(:inactive_event, from: :event) do
  active false
end

