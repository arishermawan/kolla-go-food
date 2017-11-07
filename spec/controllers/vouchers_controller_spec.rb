require 'rails_helper'

describe VouchersController do
  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end

  describe 'GET #index' do
    it "populates an array of all vouchers" do
      voucher1 = create(:voucher, code: "GOJEKINAJA")
      voucher2 = create(:voucher, code: "GOPAYAJA")
      get :index
      expect(assigns(:vouchers)).to match_array([voucher1, voucher2])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested voucher to @voucher" do
      voucher = create(:voucher)
      get :show, params: {id: voucher}
      expect(assigns(:voucher)).to eq voucher
    end

    it "render the :show template" do
      voucher = create(:voucher)
      get :show, params:{id: voucher}
      expect(response).to render_template :show

    end
  end

  describe 'GET #new' do
    it "assigns a new voucher to @voucher" do
      get :new
      expect(assigns(:voucher)).to be_a_new(Voucher)
    end

    it "render the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns a new voucher to @voucher" do
     voucher = create(:voucher)
      get :edit, params: {id: voucher}
      expect(assigns(:voucher)).to eq voucher
    end

    it "render the :edit template" do
      voucher = create(:voucher)
      get :edit, params:{id: voucher}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "save the new voucher in the database" do
        expect{
          post :create, params: { voucher: attributes_for(:voucher) }
        }.to change(Voucher, :count).by(1)
      end

      it "redirects to voucher#show" do
        post :create, params: { voucher: attributes_for(:voucher) }
        expect(response).to redirect_to(voucher_path(assigns[:voucher]))
      end
    end

    context "with invalid attributes" do
      it "does not save the new voucher in the database" do
        expect{
          post :create, params: { voucher: attributes_for(:invalid_food) }
        }.not_to change(Voucher, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { voucher: attributes_for(:invalid_food) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @voucher = create(:voucher)
    end

    context 'with valid attributes' do
      it "locates the requested @voucher" do
        patch :update, params: { id: @voucher, voucher: attributes_for(:voucher) }
        expect(assigns(:voucher)).to eq @voucher
      end

      it "changes @voucher's attributes" do
        patch :update, params: {id: @voucher, voucher: attributes_for(:voucher, code: 'GOPAYAJA') }
        @voucher.reload
        expect(@voucher.code).to eq('GOPAYAJA')
      end

      it "redirects to the voucher" do
        patch :update, params: { id: @voucher, voucher: attributes_for(:voucher) }
        expect(response).to redirect_to @voucher
      end
    end

    context 'with invalid attributes' do
      it "does not update the voucher in the database" do
        patch :update, params: { id: @voucher, voucher: attributes_for(:voucher, code: 'GOPAYAJA', valid_from: nil) }
        @voucher.reload
        expect(@voucher.code).not_to eq('GOPAYAJA')
      end
      it "re-render the :edit template" do
        patch :update, params: {id:@voucher, voucher: attributes_for(:invalid_voucher) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @voucher = create(:voucher)
    end

    it "delete the voucher from the database" do
      expect{
        delete :destroy, params: { id: @voucher }
      }.to change(Voucher, :count).by(-1)

    end

    it "redirects to the voucher#index" do
      delete :destroy, params: { id: @voucher }
      expect(response).to redirect_to vouchers_url
    end
  end
end
