require 'spec_helper'

describe Admin::CoachesController do

  let(:valid_attributes) { { "name" => "Name", "email" => "email@example" } }

  let(:valid_session) { {} }

  before do
    sign_in
  end

  describe "GET index" do
    it "assigns all coaches as @coaches" do
      coach = Coach.create! valid_attributes
      get :index, {}, valid_session
      assigns(:coaches).should eq([coach])
    end
  end

  describe "GET show" do
    it "assigns the requested coach as @coach" do
      coach = Coach.create! valid_attributes
      get :show, {:id => coach.to_param}, valid_session
      assigns(:coach).should eq(coach)
    end
  end

  describe "GET new" do
    it "assigns a new coach as @coach" do
      get :new, {}, valid_session
      assigns(:coach).should be_a_new(Coach)
    end
  end

  describe "GET edit" do
    it "assigns the requested coach as @coach" do
      coach = Coach.create! valid_attributes
      get :edit, {:id => coach.to_param}, valid_session
      assigns(:coach).should eq(coach)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Coach" do
        expect {
          post :create, {:coach => valid_attributes}, valid_session
        }.to change(Coach, :count).by(1)
      end

      it "assigns a newly created coach as @coach" do
        post :create, {:coach => valid_attributes}, valid_session
        assigns(:coach).should be_a(Coach)
        assigns(:coach).should be_persisted
      end

      it "redirects to the created coach" do
        post :create, {:coach => valid_attributes}, valid_session
        response.should redirect_to([:admin, Coach.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved coach as @coach" do
        # Trigger the behavior that occurs when invalid params are submitted
        Coach.any_instance.stub(:save).and_return(false)
        post :create, {:coach => { "name" => "invalid value" }}, valid_session
        assigns(:coach).should be_a_new(Coach)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Coach.any_instance.stub(:save).and_return(false)
        post :create, {:coach => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested coach" do
        coach = Coach.create! valid_attributes
        # Assuming there are no other coaches in the database, this
        # specifies that the Coach created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Coach.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => coach.to_param, :coach => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested coach as @coach" do
        coach = Coach.create! valid_attributes
        put :update, {:id => coach.to_param, :coach => valid_attributes}, valid_session
        assigns(:coach).should eq(coach)
      end

      it "redirects to the coach" do
        coach = Coach.create! valid_attributes
        put :update, {:id => coach.to_param, :coach => valid_attributes}, valid_session
        response.should redirect_to([:admin, coach])
      end
    end

    describe "with invalid params" do
      it "assigns the coach as @coach" do
        coach = Coach.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Coach.any_instance.stub(:save).and_return(false)
        put :update, {:id => coach.to_param, :coach => { "name" => "invalid value" }}, valid_session
        assigns(:coach).should eq(coach)
      end

      it "re-renders the 'edit' template" do
        coach = Coach.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Coach.any_instance.stub(:save).and_return(false)
        put :update, {:id => coach.to_param, :coach => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested coach" do
      coach = Coach.create! valid_attributes
      expect {
        delete :destroy, {:id => coach.to_param}, valid_session
      }.to change(Coach, :count).by(-1)
    end

    it "redirects to the coaches list" do
      coach = Coach.create! valid_attributes
      delete :destroy, {:id => coach.to_param}, valid_session
      response.should redirect_to(admin_coaches_url)
    end
  end

end
