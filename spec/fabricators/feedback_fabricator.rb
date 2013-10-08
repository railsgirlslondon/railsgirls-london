Fabricator(:feedback) do 
  invitation_id { Fabricate(:event_invitation).id }
  comments { Faker::Lorem.paragraph }
  rating 2
end
