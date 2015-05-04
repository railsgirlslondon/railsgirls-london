require 'spec_helper'

describe Admin::MembersController, :type => :controller do

  let!(:city) { Fabricate(:city) }
  let(:valid_attributes) { { "first_name" => "Maria", "last_name" => "Doe", "phone_number" => "0123123", "email" => "email@example", "city_id" => city.id } }

  let(:valid_session) { {} }

  before do
    sign_in
  end

  describe "GET index" do
    it "assigns all members as @members" do
      member = Member.create! valid_attributes
      get :index, {:city_id => city.to_param}, valid_session
      assigns(:members).should eq([member])
    end
  end

  describe "GET show" do
    it "assigns the requested member as @member" do
      member = Member.create! valid_attributes
      get :show, {:city_id => city.to_param, :id => member.to_param}, valid_session
      assigns(:member).should eq(member)
    end
  end

  describe "GET new" do
    it "assigns a new member as @member" do
      get :new, { :city_id => city.to_param}, valid_session
      assigns(:member).should be_a_new(Member)
    end
  end

  describe "GET edit" do
    it "assigns the requested member as @member" do
      member = Member.create! valid_attributes
      get :edit, {:city_id => city.to_param, :id => member.to_param}, valid_session

      assigns(:member).should eq(member)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Member" do
        expect {
          post :create, {:city_id => city.to_param, :member => valid_attributes}, valid_session
        }.to change(Member, :count).by(1)
      end

      it "assigns a newly created member as @member" do
        post :create, {:city_id => city.to_param, :member => valid_attributes}, valid_session

        assigns(:member).should be_a(Member)
        assigns(:member).should be_persisted
      end

      it "redirects to the members index" do
        post :create, {:city_id => city.to_param, :member => valid_attributes}, valid_session

        response.should redirect_to([:admin, city, :members])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved member as @member" do
        Member.any_instance.stub(:save).and_return(false)
        post :create, {:city_id => city.to_param, :member => { "name" => "invalid value" }}, valid_session

        assigns(:member).should be_a_new(Member)
      end

      it "re-renders the 'new' template" do
        Member.any_instance.stub(:save).and_return(false)
        post :create, {:city_id => city.to_param, :member => { "name" => "invalid value" }}, valid_session

        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested member" do
        member = Member.create! valid_attributes
        Member.any_instance.should_receive(:update).with({ "first_name" => "MyString" })

        put :update, {:city_id => city.to_param, :id => member.to_param, :member => { "first_name" => "MyString" }}, valid_session
      end

      it "assigns the requested member as @member" do
        member = Member.create! valid_attributes
        put :update, {:city_id => city.to_param, :id => member.to_param, :member => valid_attributes}, valid_session

        assigns(:member).should eq(member)
      end

      it "redirects to the member" do
        member = Member.create! valid_attributes
        put :update, {:city_id => city.to_param, :id => member.to_param, :member => valid_attributes}, valid_session

        response.should redirect_to([:admin, city, :members])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        member = Member.create! valid_attributes
        Member.any_instance.stub(:save).and_return(false)
        put :update, {:city_id => city.to_param, :id => member.to_param, :member => { "wrong_param" => "invalid value" }}, valid_session

        response.should render_template("edit")
      end
    end
  end

end
