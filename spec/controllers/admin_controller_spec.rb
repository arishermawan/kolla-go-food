require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
