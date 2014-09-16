require 'spec_helper'

describe Admin::MeetingsController do
  let!(:city) { Fabricate(:city) }
  let!(:meeting_type) { Fabricate(:meeting_type) }
  let(:valid_attributes) { { "date" => Date.today+1.week, "meeting_type_id" => meeting_type.id, "city_id" => city.id, "announced" => "true" } }
  let(:valid_session) { {} }

  before do
    sign_in
  end

  describe "GET index" do
    it "assigns all meetings as @meetings" do
      meeting = Meeting.create! valid_attributes
      get :index, { :city_id => city.to_param }, valid_session
      assigns(:meetings).should eq([meeting])
    end
  end

  describe "GET show" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :show, { :city_id => city.to_param, :id => meeting.to_param }, valid_session
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "GET new" do
    it "assigns a new meeting as @meeting" do
      get :new, {:city_id => city.to_param}, valid_session
      assigns(:meeting).should be_a_new(Meeting)
    end
  end

  describe "GET edit" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :edit, {:city_id => city.to_param, :id => meeting.to_param}, valid_session
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Meeting" do
        expect {
          post :create, {:city_id => city.to_param, :meeting => valid_attributes}, valid_session
        }.to change(Meeting, :count).by(1)
      end

      it "assigns a newly created meeting as @meeting" do
        post :create, {:city_id => city.to_param, :meeting => valid_attributes}, valid_session
        assigns(:meeting).should be_a(Meeting)
        assigns(:meeting).should be_persisted
      end

      it "redirects to the created meeting" do
        post :create, {:city_id => city.to_param, :meeting => valid_attributes}, valid_session
        response.should redirect_to(admin_city_meetings_path(city))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved meeting as @meeting" do
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:city_id => city.to_param, :meeting => { "date" => "invalid value" }}, valid_session
        assigns(:meeting).should be_a_new(Meeting)
      end

      it "re-renders the 'new' template" do
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:city_id => city.to_param, :meeting => { "date" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested meeting" do
        meeting = Meeting.create! valid_attributes
        Meeting.any_instance.should_receive(:update).with({ "date" => "2013-06-20 01:59:21" })
        put :update, {:city_id => city.to_param,:id => meeting.to_param, :meeting => { "date" => "2013-06-20 01:59:21" }}, valid_session
      end

      it "assigns the requested meeting as @meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, { :city_id => city.to_param, :id => meeting.to_param, :meeting => valid_attributes}, valid_session
        assigns(:meeting).should eq(meeting)
      end

      it "redirects to the meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, {:city_id => city.to_param, :id => meeting.to_param, :meeting => valid_attributes}, valid_session
        response.should redirect_to(admin_city_meetings_path)
      end
    end

    describe "with invalid params" do
      it "assigns the meeting as @meeting" do
        meeting = Meeting.create! valid_attributes
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, {:city_id => city.to_param,:id => meeting.to_param, :meeting => { "date" => "invalid value" }}, valid_session
        assigns(:meeting).should eq(meeting)
      end

      it "re-renders the 'edit' template" do
        meeting = Meeting.create! valid_attributes
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, { :city_id => city.to_param, :id => meeting.to_param, :meeting => { "date" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested meeting" do
      meeting = Meeting.create! valid_attributes
      expect {
        delete :destroy, { :city_id => city.to_param, :id => meeting.to_param}, valid_session
      }.to change(Meeting, :count).by(-1)
    end

    it "redirects to the meetings list" do
      meeting = Meeting.create! valid_attributes
      delete :destroy, { :city_id => city.to_param, :id => meeting.to_param}, valid_session
      response.should redirect_to(admin_city_meetings_path(city))
    end
  end
end
