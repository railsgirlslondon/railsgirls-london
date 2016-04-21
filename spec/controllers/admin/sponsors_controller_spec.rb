require 'spec_helper'
describe Admin::SponsorsController, :type => :controller do

  let(:valid_attributes) { { name: "MyString", website: "http://some/website/com" } }
  let(:valid_session) { {} }

  before do
    sign_in
  end

  describe "GET index" do
    it "assigns all sponsors as @sponsors" do
      sponsor = Sponsor.create! valid_attributes
      get :index, {}, valid_session
      assigns(:sponsors).should eq([sponsor])
    end
  end

  describe "GET show" do
    it "assigns the requested sponsor as @sponsor" do
      sponsor = Sponsor.create! valid_attributes
      get :show, {:id => sponsor.to_param}, valid_session
      assigns(:sponsor).should eq(sponsor)
    end
  end

  describe "GET new" do
    it "assigns a new sponsor as @sponsor" do
      get :new, {}, valid_session
      assigns(:sponsor).should be_a_new(Sponsor)
    end
  end

  describe "GET edit" do
    it "assigns the requested sponsor as @sponsor" do
      sponsor = Sponsor.create! valid_attributes
      get :edit, {:id => sponsor.to_param}, valid_session
      assigns(:sponsor).should eq(sponsor)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Sponsor" do
        expect {
          post :create, {:sponsor => valid_attributes}, valid_session
        }.to change(Sponsor, :count).by(1)
      end

      it "assigns a newly created sponsor as @sponsor" do
        post :create, {:sponsor => valid_attributes}, valid_session
        assigns(:sponsor).should be_a(Sponsor)
        assigns(:sponsor).should be_persisted
      end

      it "redirects to the created sponsor" do
        post :create, {:sponsor => valid_attributes}, valid_session
        response.should redirect_to([:admin, Sponsor.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sponsor as @sponsor" do
        allow_any_instance_of(Sponsor).to receive(:save).and_return(false)
        post :create, {:sponsor => { "name" => "invalid value" }}, valid_session
        assigns(:sponsor).should be_a_new(Sponsor)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Sponsor).to receive(:save).and_return(false)
        post :create, {:sponsor => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested sponsor" do
        sponsor = Sponsor.create! valid_attributes
        expect_any_instance_of(Sponsor).to receive(:update).with({ "name" => "MyString" })
        put :update, {:id => sponsor.to_param, :sponsor => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested sponsor as @sponsor" do
        sponsor = Sponsor.create! valid_attributes
        put :update, {:id => sponsor.to_param, :sponsor => valid_attributes}, valid_session
        assigns(:sponsor).should eq(sponsor)
      end

      it "redirects to the sponsor" do
        sponsor = Sponsor.create! valid_attributes
        put :update, {:id => sponsor.to_param, :sponsor => valid_attributes}, valid_session
        response.should redirect_to([:admin, sponsor])
      end
    end

    describe "with invalid params" do
      it "assigns the sponsor as @sponsor" do
        sponsor = Sponsor.create! valid_attributes
        allow_any_instance_of(Sponsor).to receive(:save).and_return(false)
        put :update, {:id => sponsor.to_param, :sponsor => { "name" => "invalid value" }}, valid_session
        assigns(:sponsor).should eq(sponsor)
      end

      it "re-renders the 'edit' template" do
        sponsor = Sponsor.create! valid_attributes
        allow_any_instance_of(Sponsor).to receive(:save).and_return(false)
        put :update, {:id => sponsor.to_param, :sponsor => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested sponsor" do
      sponsor = Sponsor.create! valid_attributes
      expect {
        delete :destroy, {:id => sponsor.to_param}, valid_session
      }.to change(Sponsor, :count).by(-1)
    end

    it "redirects to the sponsors list" do
      sponsor = Sponsor.create! valid_attributes
      delete :destroy, {:id => sponsor.to_param}, valid_session
      response.should redirect_to(admin_sponsors_path)
    end
  end

end
