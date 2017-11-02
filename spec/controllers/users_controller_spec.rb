require 'rails_helper'

describe FoodsController do

  # describe "POST#create" do
  #   context "with valid attributes" do

  #     it "saves the new user in the database" do
  #       expect{
  #         post:create, params:{ user: attributes_for(:user) }
  #       }.to change(User, :count).by(1)
  #     end

  #     it "redirect to users#index" do
  #       post: create, params: { user}
  #     end
  #   end
  # end

  # describe 'GET#Index'

  describe "PATCH#update" do
    before :each do
      @user = create(:user, password: 'oldpassword', password_confirmation: 'oldpassword')
    end

    context "with valid attributes" do

      it "locates the requested @user" do
        patch :update, params:{ id:@user, user:attributes_for(:user) }
        expect(assigns(:user)).to eq @user
      end

      it "saves new password" do
        patch :update, params: { id:@user, user:attributes_for(:user, password: "newlongpassword", password_confirmation: "newlongpassword" ) }
        @user.reload
        expect(@user.authenticate('newlongpassword')).to eq(@user)
      end

      it "redirect to user#index" do
         patch :update, params:{ id:@user, user:attributes_for(:user) }
         expect(response).to redirect_to users_url
      end

      it "disables login with old password" do
        patch :update, params: { id:@user, user:attributes_for(:user, password: "newlongpassword", password_confirmation: "newlongpassword" ) }
        @user.reload
        expect(@user.authenticate('oldpassword')).to eq(flase)
      end

    end


    context "with valid attributes" do

      it "doesnot update the user in the database" do
        patch :update, params:{ id:@user, user:attributes_for(:user, password: nil, password_confirmation: nil) }
        @user.reload
        expect(@user.authenticate(nil)).to eq (false)
      end

      it "re-renders the :edit template" do
         patch :update, params:{ id:@user, user:attributes_for(:invalid_password) }
         expect(response).to render_template :edit
      end
    end
  end

  # describe 'DELETE #destroy' do
  #   before :each do
  #     @user = create(:user)
  #   end

  #   it "delete the food from the database" do
  #     expect{
  #       delete :destroy, params: { id: @food }
  #     }.to change(Food, :count).by(-1)

  #   end

  #   it "redirects to the food#index" do
  #     delete :destroy, params: { id: @food }
  #     expect(response).to redirect_to foods_url
  #   end
  # end

end
