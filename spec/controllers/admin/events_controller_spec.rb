require 'spec_helper'

describe Admin::EventsController do
  let(:city) { City.create! name: "some city" }
  let(:valid_attributes) do
    {"description" => "MyString", city_id: city.id, active: true, starts_on: Time.now, ends_on: Time.now}
  end

  before do
    sign_in
  end

  describe "GET index" do
    it "assigns all events as @events" do
      event = Event.create! valid_attributes
      get :index, {}
      assigns(:events).should eq([event])
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :show, {:id => event.to_param}
      assigns(:event).should eq(event)
    end
  end

  describe "GET new" do
    it "assigns a new event as @event" do
      get :new, {}
      assigns(:event).should be_a_new(Event)
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :edit, {:id => event.to_param}
      assigns(:event).should eq(event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, {:event => valid_attributes}
        }.to change(Event, :count).by(1)
      end

      it "redirects to the created event" do
        post :create, {:event => valid_attributes}
        response.should redirect_to([:admin, Event.last])
      end
    end

    describe "with invalid params" do
      before do
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => { :wrong_params => true  }}
      end

      it "assigns a newly created but unsaved event as @event" do
        assigns(:event).should be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested event" do
        event = Event.create! valid_attributes
        Event.any_instance.should_receive(:update_attributes).with({ "description" => "MyString" })
        put :update, {:id => event.to_param, :event => { "description" => "MyString" }}
      end

      it "assigns the requested event as @event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}
        assigns(:event).should eq(event)
      end

      it "redirects to the event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}
        response.should redirect_to([:admin, event])
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        event = Event.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => { "description" => "invalid value" }}
        assigns(:event).should eq(event)
      end

      it "re-renders the 'edit' template" do
        event = Event.create! valid_attributes
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => { "description" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect {
        delete :destroy, {:id => event.to_param}
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = Event.create! valid_attributes
      delete :destroy, {:id => event.to_param}
      response.should redirect_to(admin_events_url)
    end
  end

end
