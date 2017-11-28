require 'rails_helper'

RSpec.describe StoreController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "retunn a list of restaurants" do
      restaurant1 = create(:restaurant)
      restaurant2 = create(:restaurant)
      get :index
      expect(assigns(:restaurants)).to eq([restaurant1, restaurant2])
    end

    it "includes CurrentCart" do
      expect(StoreController.ancestors.include? CurrentCart).to eq(true)
    end
  end
end
