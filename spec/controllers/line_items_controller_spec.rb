require 'rails_helper'

describe LineItemsController do
  describe 'POST #create' do
    before :each do
      @food = create(:food)
    end

    it "Includes CurrentCart" do
      expect(LineItemsController.ancestors.include? CurrentCart).to eq(true)
    end

    context "with existing cart" do 
      it "does not create a new cart before saving a new line_item" do
        cart = create(:cart)
        session[:cart_id] = cart.id

        expect{
          post :create, params: {food_id: @food.id}
        }.not_to change(Cart, :count)

      end
    end 

    context "without existing cart" do 
      it "creates a new cart before saving a new line_item" do
        expect{
          post :create, params: {food_id: @food.id}
        }.to change(Cart, :count).by(1)
      end
    end

    it "saves the new line_item in the database" do
      expect{
        post :create, params: {food_id: @food.id}
      }.to change(LineItem, :count).by(1)
    end
    it "redirect to carts/#show" do
      post :create, params: { food_id: @food.id }
      expect(response).to redirect_to(cart_path(assigns(:line_item).cart))
    end


    it "does not change the number of line items if same food is added" do

    end
    
    it "increment the quantity of line item if same food added" do

    end

  end
end