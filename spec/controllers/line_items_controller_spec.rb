require 'rails_helper'


# describe CartController do
#   describe 'DELETE #destroy' do

#     before :each do
#       @cart = create(:cart)
#       session[:cart_id] = @cart.id
#     end

#     it "should remove only user own cart" do
#       expect{
#         delete :destroy, params: { id: @cart }
#       }.to change(Cart, :count).by(-1)
#     end

#     it "should remove cart form user's session" do
#       delete :destroy, params: { id: cart.id }
#       expect(session).not_to include(@cart)
#     end

#     it "redirect to store index" do
#       delete :destroy, params: { id: @cart }
#       expect(response).to redirect_to carts_url
#     end
#   end
# end

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
    it "redirect to store inex" do
      post :create, params: { food_id: @food.id }
      # expect(response).to redirect_to(cart_path(assigns(:line_item).cart))
      expect(response).to redirect_to (store_index_path)
    end

    context "with existing line_item with the same food" do
      before :each do
        cart = create(:cart)
        session[:cart_id] = cart.id
        line_item = create(:line_item, food: @food, cart: cart)
      end

      it "does not save the new line_item in the database" do
        expect{
          post :create, params: { food_id: @food.id }
        }.not_to change(LineItem, :count)
      end

      it "increments the quantity of line_item with the same food" do
        post :create, params: { food_id: @food.id }
        expect(assigns(:line_item).quantity).to eq(2)
      end
    end

    context "without existing line_item with the same food" do
      it "saves the new line_item in the database" do
        expect{
          post :create, params: { food_id: @food.id }
        }.to change(LineItem, :count).by(1)
      end
    end

     context "with the different restaurant" do
      before :each do
        cart = create(:cart)
        session[:cart_id] = cart.id
        restaurant1 = create(:restaurant)
        food1 = create(:food, restaurant: restaurant1)
        restaurant2 = create(:restaurant)
        food2 = create(:food, restaurant: restaurant2)

        line_item1 = create(:line_item, food: food1, cart: cart)
      end

      it "doesn't save the new line_item in the database" do
        expect{
          post :create, params: { food_id: @food.id }
        }.not_to change(LineItem, :count)
      end


    end

  end
end
