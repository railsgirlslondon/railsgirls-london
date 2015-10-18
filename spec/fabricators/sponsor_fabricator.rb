Fabricator(:sponsor) do
  name "An awesome sponsor"
  website "http://example.com"
end

Fabricator(:sponsor_with_address, from: :sponsor) do
  address_line_1 "A house"
  address_line_2 "123 Street st"
  address_city "Sama"
  address_postcode "N1 3TY"
end

Fabricator(:sponsorship) do
  sponsor
end

Fabricator(:hosting, from: :sponsorship) do
  sponsor(fabricator: :sponsor_with_address)
  host true
end

Fabricator(:event_sponsorship, from: :sponsorship) do
  sponsorable_type { 'Event' }
  sponsorable_id { Fabricate(:event).id }
end
