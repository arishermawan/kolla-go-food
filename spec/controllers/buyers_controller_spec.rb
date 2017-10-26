require 'rails_helper'

describe BuyersController do
  describe 'GET #index' do
    context 'with params[:letter]' do
      it "populates an array of buyers starting with the letter" do
        aris = create(:buyer, name:"Aris")
        budi = create(:buyer, name:"Budi")
        get :index, params:{ letter: 'A' }
        expect(assigns(:buyers)).to match_array([aris])
      end

      it "render the :index template" do
        get :index, params:{ letter: 'N' }
        expect(response).to render_template :index    
      end
    end

    context 'without params[:letter]' do
     it "populates an array of all buyers" do 
        aris = create(:buyer, name:"Aris")
        budi = create(:buyer, name:"Budi")
        get :index
        expect(assigns(:buyers)).to match_array([aris, budi])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested buyer to @buyer" do
      buyer = create(:buyer)
      get :show, params: {id: buyer}
      expect(assigns(:buyer)).to eq buyer
    end

    it "render the :show template" do
      buyer = create(:buyer)
      get :show, params:{id: buyer}
      expect(response).to render_template :show
    end   
  end

  describe 'GET #new' do
    it "assigns a new buyer to @buyer" do
      get :new
      expect(assigns(:buyer)).to be_a_new(Buyer)
    end
    
    it "render the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns a new buyer to @buyer" do
     buyer = create(:buyer)
      get :edit, params: {id: buyer}
      expect(assigns(:buyer)).to eq buyer
    end

    it "render the :edit template" do
      buyer = create(:buyer)
      get :edit, params:{id: buyer}
      expect(response).to render_template :edit
    end   
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "save the new buyer in the database" do
        expect{
          post :create, params: { buyer: attributes_for(:buyer) }
        }.to change(Buyer, :count).by(1)
      end

      it "redirects to buyer#show" do
        post :create, params: { buyer: attributes_for(:buyer) }
        expect(response).to redirect_to(buyer_path(assigns[:buyer]))
      end
    end

    context "with invalid attributes" do
      it "does not save the new buyer in the database" do
        expect{
          post :create, params: { buyer: attributes_for(:invalid_food) }
        }.not_to change(Buyer, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { buyer: attributes_for(:invalid_food) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @buyer = create(:buyer)
    end

    context 'with valid attributes' do
      it "locates the requested @buyer" do
        patch :update, params: { id: @buyer, buyer: attributes_for(:buyer) }
        expect(assigns(:buyer)).to eq @buyer
      end

      it "changes @buyer's attributes" do
        patch :update, params: {id: @buyer, buyer: attributes_for(:buyer, name: 'Nasi Uduk') }
        @buyer.reload
        expect(@buyer.name).to eq('Nasi Uduk')
      end

      it "redirects to the buyer" do
        patch :update, params: { id: @buyer, buyer: attributes_for(:buyer) }
        expect(response).to redirect_to @buyer
      end
    end

    context 'with invalid attributes' do
      it "does not update the buyer in the database" do
        patch :update, params: { id: @buyer, buyer: attributes_for(:buyer, name: 'Aris', address: nil) }
        @buyer.reload
        expect(@buyer.name).not_to eq('Aris')
      end
      it "re-render the :edit template" do
        patch :update, params: {id:@buyer, buyer: attributes_for(:invalid_buyer) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @buyer = create(:buyer) 
    end

    it "delete the buyer from the database" do
      expect{
        delete :destroy, params: { id: @buyer }
      }.to change(Buyer, :count).by(-1) 

    end

    it "redirects to the buyer#index" do
      delete :destroy, params: { id: @buyer }
      expect(response).to redirect_to buyers_url
    end
  end
end