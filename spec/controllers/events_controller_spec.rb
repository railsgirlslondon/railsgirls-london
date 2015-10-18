require 'spec_helper'

describe EventsController, :type => :controller do
  describe "GET #show" do
    Given(:event) { Fabricate(:event) }

    When { get :show, id: event.to_param }
    Then { expect(response).to render_template(:show) }
  end
end
