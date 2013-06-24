require 'spec_helper'

feature "viewing an event" do
  Given(:city) { Fabricate(:city) }

  context "when it is active" do

    context "when the registration deadline is set" do
      Given!(:event) { Fabricate(:event, city: city) }
      Given!(:host) do
       Fabricate(:sponsor,
                 address_line_1: "A house",
                 address_line_2: "123 Street st",
                 address_city: "London",
                 address_postcode: "N1 3TY")
      end

      Given!(:sponsor) do
       Fabricate(:sponsor,
                 address_line_1: "Not a hosting house")
      end

      Given { Fabricate(:event_sponsorship, sponsorable_id: event.id, sponsor: host, host: true) }
      Given { Fabricate(:event_sponsorship, sponsorable_id: event.id, sponsor: sponsor, host: false) }

      When do
        visit city_event_path(city, event)
      end

      Then { page.has_content? "Apply to the event." }
      And { page.has_content? host.name }
      And { page.has_content? "A house" }
      And { page.has_content? "123 Street st" }
      And { page.has_content? "London" }
      And { page.has_content? "N1 3TY" }

      And { page.has_content? sponsor.name }
      And { not page.has_content? "Not a hosting house" }
    end

    context "and no registration deadline is set" do
      Given!(:event) { Fabricate(:event, registration_deadline: nil, city: city) }

      When do
        visit city_event_path(city, event)
      end

      Then { page.has_content? "Applications are not available for this event." }
    end

    context 'registration deadline has passed' do
      Given!(:event) { Fabricate(:event, registration_deadline: Date.yesterday, city: city) }

      When do
        visit city_event_path(city, event)
      end

      Then { page.has_content? "Applications are now closed." }
    end

  end

  context "when inactive" do
    Given!(:event) { Fabricate(:inactive_event, city: city) }

    context "when the registration deadline is set" do

      When do
        visit city_event_path(city, event)
      end

      Then { page.has_content? "This event has already taken place." }

    end
  end
end
