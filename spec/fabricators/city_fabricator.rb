Fabricator(:city) do
  name { Faker::Address.city }
  twitter { Faker::Lorem.word }
  email { Faker::Internet.email }
end

Fabricator(:city_with_members, from: :city) do
  members(count: 5)
end
