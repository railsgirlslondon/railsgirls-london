Fabricator(:meeting_type) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.paragraph }
  frequency { Faker::Lorem.word }
end
