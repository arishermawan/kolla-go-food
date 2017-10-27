require 'rails_helper'

RSpec.describe StoreController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "retunn a list of foods, ordered by name" do
      nasi_rames = create(:food, name: "Nasi Rames")
      kerak_telor = create(:food, name: "Kerak telor")
      get :index
      expect(assigns(:foods)).to eq([kerak_telor, nasi_rames])
    end
  end

end
