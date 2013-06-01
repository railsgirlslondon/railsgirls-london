Fabricator(:registration) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.safe_email }
  gender { Faker::Lorem.word }
  phone_number { Faker::PhoneNumber.phone_number }
  reason_for_applying { Faker::Lorem.paragraph }
  programming_experience { Faker::Lorem.paragraph }
  uk_resident { Faker::Lorem.word }
  os { Faker::Lorem.word }
  os_version { Faker::Lorem.word }
  spoken_languages { Faker::Lorem.word }
  preferred_language { Faker::Lorem.word }
  reason_for_applying { Faker::Lorem.paragraph }
  address { Faker::Lorem.word }
  event
end
