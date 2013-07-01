Fabricator(:member) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.safe_email }
  phone_number { Faker::PhoneNumber.phone_number }
  city { Fabricate(:city) }
end
