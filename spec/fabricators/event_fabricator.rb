Fabricator(:event) do
  description { Faker::Lorem.paragraph }
  city
  starts_on { Date.today+1.month }
  ends_on { Date.today+1.month+1.day }
end
