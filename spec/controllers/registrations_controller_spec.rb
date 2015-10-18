require 'spec_helper'

describe RegistrationsController, :type => :controller do
  describe "POST #create" do

    context "when validation failures occur" do
      Given(:event)  { Fabricate(:event) }

      let!(:registration_count) { Registration.count }

      Invariant { Registration.count == registration_count }

      When {
        post  :create,
              event_id: event.to_param,
              registration: {}
      }

      Then { expect(response).to render_template(:new) }
      And  { expect(assigns(:registration).errors).not_to be_empty }
    end

    describe "GET #new" do
      context "when the event is accepting registrations" do

        Given(:event) {
          Fabricate(
            :event,
            registration_deadline: Time.now + 3.days
          )
        }

        When {
          get  :new,
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
            registration_deadline: Time.now - 7.days
          )
        }


        When {
          get  :new,
                event_id: event.to_param,
                registration: {}
        }

        Then {
          expect(response).to redirect_to(event_path(event))
        }

      end

    end
  end
end
