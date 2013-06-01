Fabricator(:city) do
  name { Faker::Address.city }
  twitter { Faker::Lorem.word }
  email { Faker::Internet.email }
end
