require 'spec_helper'

feature "viewing an event" do
  context "when it is active" do
    context "when the registration deadline is set" do
      Given!(:event) { Fabricate(:event) }
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
        visit event_path(event)
      end

      Then { page.has_content? "Apply for the event" }
      And { page.has_content? host.name }
      And { page.has_content? "A house" }
      And { page.has_content? "123 Street st" }
      And { page.has_content? "London" }
      And { page.has_content? "N1 3TY" }

      And { page.has_content? sponsor.name }
      And { not page.has_content? "Not a hosting house" }
    end

    context "and no registration deadline is set" do
      Given!(:event) { Fabricate(:event, registration_deadline: nil) }

      When do
        visit event_path(event)
      end

      Then { page.has_content? "Applications are not available for this event." }
    end

    context 'registration deadline has passed' do
      Given!(:event) { Fabricate(:event, registration_deadline: Date.yesterday) }

      When do
        visit event_path(event)
      end

      Then { page.has_content? "Applications are now closed." }
    end

  end

  context "when an event is in the past" do
    let!(:event) { Fabricate(:inactive_event) }

    it "makes user feedback available" do
      visit event_path(event)

      page.has_content? "This event has already taken place."
      page.has_content? "Did you attend out workshop on the #{event.dates}"
    end
  end
end
