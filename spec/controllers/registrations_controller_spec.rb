require 'spec_helper'

describe RegistrationsController do
  describe "POST #create" do
    Given(:city) { Fabricate(:city) }

    context "when validation failures occur" do
      Given(:event)  { Fabricate(:event, city: city) }

      let!(:registration_count) { Registration.count }

      Invariant { Registration.count == registration_count }

      When { post :create, city_id: city.to_param, event_id: event.to_param, registration: {} }
      Then { expect(response).to render_template(:new) }
      And  { expect(assigns(:registration).errors).not_to be_empty}
      And  { expect(assigns(:city)).to eq(city)}
    describe "GET #new" do
      context "when the event is accepting registrations" do

        Given(:event) {
          Fabricate(
            :event,
            city: city,
            registration_deadline: Time.now + 3.days
          )
        }

        When {
          get  :new,
                city_id: city.to_param,
                event_id: event.to_param,
                registration: {}
        }

        Then {
          expect(response.status).to eql(200)
        }

      end

      context "when the event isn't accepting registrations" do

        Given(:event) {
          Fabricate(
            :event,
            city: city,
            registration_deadline: Time.now - 7.days
          )
        }


        When {
          get  :new,
                city_id: city.to_param,
                event_id: event.to_param,
                registration: {}
        }

        Then {
          expect(response).to redirect_to(city_event_path(city, event))
        }

      end

    end
  end
end
