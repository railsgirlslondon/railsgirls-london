require 'spec_helper'

describe Admin::CoachesController, :type => :controller do

  let(:valid_attributes) { { "name" => "Name", "email" => "email@example" } }

  let(:valid_session) { {} }

  before do
    sign_in
  end

  describe "GET index" do
    it "assigns all coaches as @coaches" do
      coach = Coach.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:coaches)).to eq([coach])
    end
  end

  describe "GET show" do
    it "assigns the requested coach as @coach" do
      coach = Coach.create! valid_attributes
      get :show, params: {:id => coach.to_param}, session: valid_session
      expect(assigns(:coach)).to eq(coach)
    end
  end

  describe "GET new" do
    it "assigns a new coach as @coach" do
      get :new, params: {}, session: valid_session
      expect(assigns(:coach)).to be_a_new(Coach)
    end
  end

  describe "GET edit" do
    it "assigns the requested coach as @coach" do
      coach = Coach.create! valid_attributes
      get :edit, params: {:id => coach.to_param}, session: valid_session
      expect(assigns(:coach)).to eq(coach)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Coach" do
        expect {
          process :create, method: :post, params: {:coach => valid_attributes}, session: valid_session
        }.to change(Coach, :count).by(1)
      end

      it "assigns a newly created coach as @coach" do
        process :create, method: :post, params: {:coach => valid_attributes}, session: valid_session
        expect(assigns(:coach)).to be_a(Coach)
        expect(assigns(:coach)).to be_persisted
      end

      it "redirects to the created coach" do
        process :create, method: :post, params: {:coach => valid_attributes}, session: valid_session
        expect(response).to redirect_to([:admin, Coach.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved coach as @coach" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Coach).to receive(:save).and_return(false)
        process :create, method: :post, params: {:coach => { "name" => "invalid value" }}, session: valid_session
        expect(assigns(:coach)).to be_a_new(Coach)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Coach).to receive(:save).and_return(false)
        process :create, method: :post, params: {:coach => { "name" => "invalid value" }}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested coach", pending: :true do
        #FIXME
        coach = Coach.create! valid_attributes
        # Assuming there are no other coaches in the database, this
        # specifies that the Coach created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        # expect_any_instance_of(Coach).to receive(:update).with(ActionController::Parameters.new("name" => "MyString").permit!‌​(:name))
        # process :update, method: :put, params: {:id => coach.to_param, :coach => { "name" => "MyString" }}, session: valid_session
        expect_any_instance_of(Coach).to receive(:update).with({"name" => "MyString"})
        process :update, method: :put, params: {:id => coach.to_param, :coach => { "name" => "MyString" }}, session: valid_session
      end

      it "assigns the requested coach as @coach" do
        coach = Coach.create! valid_attributes
        process :update, method: :put, params: {:id => coach.to_param, :coach => valid_attributes}, session: valid_session
        expect(assigns(:coach)).to eq(coach)
      end

      it "redirects to the coach" do
        coach = Coach.create! valid_attributes
        process :update, method: :put, params: {:id => coach.to_param, :coach => valid_attributes}, session: valid_session
        expect(response).to redirect_to([:admin, coach])
      end
    end

    describe "with invalid params" do
      it "assigns the coach as @coach" do
        coach = Coach.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Coach).to receive(:save).and_return(false)
        process :update, method: :put, params: {:id => coach.to_param, :coach => { "name" => "invalid value" }}, session: valid_session
        expect(assigns(:coach)).to eq(coach)
      end

      it "re-renders the 'edit' template" do
        coach = Coach.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Coach).to receive(:save).and_return(false)
        process :update, method: :put, params: {:id => coach.to_param, :coach => { "name" => "invalid value" }}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested coach" do
      coach = Coach.create! valid_attributes
      expect {
        process :destroy, method: :delete, params: {:id => coach.to_param}, session: valid_session
      }.to change(Coach, :count).by(-1)
    end

    it "redirects to the coaches list" do
      coach = Coach.create! valid_attributes
      process :destroy, method: :delete, params: {:id => coach.to_param}, session: valid_session
      expect(response).to redirect_to(admin_coaches_path)
    end
  end

end
