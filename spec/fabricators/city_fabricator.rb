Fabricator(:city) do
  name "london"
  twitter { Faker::Lorem.word }
  email { Faker::Internet.email }
  social_media { %w{github facebook}.map { |s| Fabricate(:social_medium, name: s) } }
end

Fabricator(:city_without_social_media, class_name: :city) do
  name { Faker::Address.city }
  twitter { Faker::Lorem.word }
  email { Faker::Internet.email }
end

Fabricator(:city_with_members, from: :city) do
  members(count: 5)
end
