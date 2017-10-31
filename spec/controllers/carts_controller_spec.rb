require 'rails_helper'


describe CartsController do

let(:valid_session) { {} }

  describe 'DELETE #destroy' do
    before :each do 
      @cart = create(:cart)
      session[:cart_id] = @cart.id
    end

    context "with valid cart_id" do 
      it "destroys the the requested cart" do
        expect{
          delete :destroy, params: {id: @cart.id}, session: valid_session
          }.to change(Cart, :count).by(-1)
      end

      it "removes the cart from user session" do
          delete :destroy, params: {id: @cart.id}, session: valid_session
          expect(session[:cart_id]).to eq(nil)
      end

      it "redirects to the store home page" do
          delete :destroy, params: {id: @cart.id}, session: valid_session
          expect(response).to redirect_to(store_index_path)
      end      
    end


    context "with invalid cart_id" do
      it "does not destroy the requested cart" do
        other_cart = create(:cart)
        expect{
          delete :destroy, params:{id: other_cart.id}, session: valid_session
        }.not_to change(Cart, :count)
      end
    end
  end
end
 
#   end
# end


    # before :each do
    #   @cart = create(:cart)
    #   session[:cart_id] = @cart.id 
    # end

    # it "should remove only user own cart" do
    #   expect{
    #     delete :destroy, params: { id: @cart }
    #   }.to change(Cart, :count).by(-1)
    # end

    # it "should remove cart form user's session" do
    #   delete :destroy, params: { id: cart.id }
    #   expect(session).not_to include(@cart)
    # end

    # it "redirect to store index" do
    #   delete :destroy, params: { id: @cart }
    #   expect(response).to redirect_to carts_url
    # end

