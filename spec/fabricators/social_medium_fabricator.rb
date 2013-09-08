Fabricator(:social_medium) do
  name { %{ github facebook gplus }.sample }
  url { Faker::Internet.domain_name }
end
