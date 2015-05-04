require 'spec_helper'

describe MeetingsController, :type => :controller do
  let!(:city) { Fabricate(:city) }
  let!(:meeting_type) { Fabricate(:meeting_type) }
  let(:valid_attributes) { { "date" => Date.today+1.week, "meeting_type_id" => meeting_type.to_param, "city_id" => city.id, "announced" => "true" } }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all meetings as @meetings" do
      meeting = Meeting.create! valid_attributes
      get :index, {:city_id => city.to_param}, valid_session
      assigns(:meetings).should eq([meeting])
    end
  end

  describe "GET show" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :show, { :city_id => city.to_param, :id => meeting.to_param}, valid_session
      assigns(:meeting).should eq(meeting)
    end
  end

end
