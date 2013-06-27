Fabricator(:coach) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  twitter { Faker::Lorem.word }
end
