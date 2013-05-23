require 'spec_helper'

describe RegistrationsController do
  describe "POST #create" do
    Given(:city) { City.create! name: "London" }

    context "when validation failures occur" do
      let!(:registration_count) { Registration.count }

      Invariant { Registration.count == registration_count }

      When { post :create, city_id: city.id, registration: {} }
      Then { expect(response).to render_template(:new) }
      And  { expect(assigns(:registration).errors).not_to be_empty}
      And  { expect(assigns(:city)).to eq(city)}
    end
  end
end