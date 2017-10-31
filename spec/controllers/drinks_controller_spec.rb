require 'rails_helper'

describe DrinksController do
  describe 'GET #index' do
    context "without params[:letter]" do
      it "populates array of drinks starting by letter" do
        drink1 = create(:drink, name:"coffe")
        drink2 = create(:drink, name:"juicy")
        get :index, params:{letter:'c'}
        expect(assigns(:drinks)).to match_array([drink1])
      end

      it "render the :index template" do
        get :index, params:{ letter:'c' }
        expect(response).to render_template :index      
      end
    end
      

    context "with params[:letter]" do
      it "populates array of all drinks" do
        drink1 = create(:drink, name:"coffe")
        drink2 = create(:drink, name:"juicy")
        get :index
        expect(assigns(:drinks)).to match_array([drink1, drink2])
      end

      it "render the :index template" do
        get :index
        expect(response).to render_template :index      
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested drink to @drink" do
      drink = create(:drink)
      get :show, params:{id: drink}
      expect(assigns(:drink)).to eq drink
    end

    it "render the :show template" do
      drink = create(:drink)
      get :show, params:{id: drink}
      expect(response).to render_template :show
    end
  end
  
  describe 'GET #new' do
    it "assigns a new Drink to @drink" do
      get :new
      expect(assigns(:drink)).to be_a_new(Drink)
    end

    it "render the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assign a new Drink to @Drink " do
      drink = create(:drink)
      get :edit. params: {id: drink}
      expect(assigns(:drink)).to eq(drink)
    end
    
    it "render edit template" do
      get :edit
      expect(response).to render_template :edit
    end    
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "save the new Drink in the database" do
        expect{
          post :create, params:{ drink: attributes_for(:drink) }
        }.to change(Drink, :count).by(1)
      end

      it "redirects to drink#show" do
        post :create, params:{ drink: attributs_for(:drink) }
        expect().to redirect_to(drink_path(assigns[:drink]))
      end
    end

    context "with invalid attributes" do
      it "doesnt save the new Drink in the database" do
      end

      it "re-renders the :new template" do 
      end
    end
    
  end

  # describe 'PATCH #udate' do
  #   before :each do

  #   end
      
  #   context 'with valid attributes' do
  #     it "locates the requested @drink" do
  #     end

  #     it "changes @drink's attributes" do
  #     end

  #     it "redirect to drink" do
  #     end
  #   end

  #   context "with invalid attributes" do
  #     it "doesnt update the new Drink in the database" do
  #     end

  #     it "re-renders the :edit template" do
  #     end
  #   end
    
  # end

  # describe 'DELETE #destroy' do
  #   before :each do 
  #   end
    
  #   it "delete the drink from the database"  do 
  #   end

  #   it "redirect to the drink#index from the database"  do 
  #   end
      
  #   end
  # end


end
