Fabricator(:coach) do
  name { Faker::Name.name }
  twitter { Faker::Lorem.word }
  email { Faker::Internet.email }
end
