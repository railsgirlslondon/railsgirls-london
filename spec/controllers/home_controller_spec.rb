require 'spec_helper'

describe HomeController, type: :controller do

  describe "GET 'index'" do
    context "when there is more than one city" do
      Given!(:events) { 2.times.map { Fabricate(:event)  } }

      When { get 'index' }

      Then { expect(response).to render_template(:index) }
      And { expect(assigns(:events)).to match_array(events) }
    end

  end

end
