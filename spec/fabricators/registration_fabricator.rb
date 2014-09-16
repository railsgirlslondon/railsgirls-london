Fabricator(:registration) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.safe_email }
  email_confirmation { |attrs| attrs[:email] }
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
  terms_of_service  "1"
end

Fabricator(:attended_registration, from: :registration) do
  selection_state { "accepted" }
  attending { true }
end

Fabricator(:weeklies_registration, from: :registration) do
  selection_state { "RGL Weeklies" }
end

Fabricator(:waiting_list_registration, from: :registration) do
  selection_state { "waiting list" }
end
