require 'rails_helper'

describe AdminController do

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end


  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end

  describe 'POST #index Foods' do
    context "submit food with empty form" do
      it "populates an array of all foods" do
        food1 = create(:food, name:'mie ayam')
        food2 = create(:food, name:'mie telor')
        post :index, params:{"name"=>"", "desc"=>"", "min"=>"", "max"=>"","submit"=>"food"}
        expect(assigns(:foods)).to match_array([food1, food2])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "submit food with name" do
      it "populates an array of foods when food.name like params:{'name'}" do
        food1 = create(:food, name:'mie ayam')
        food2 = create(:food, name:'mie telor')
        post :index, params:{"name"=>"ayam", "desc"=>"", "min"=>"", "max"=>"","submit"=>"food"}
        expect(assigns(:foods)).to match_array([food1])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "submit food with description" do
      it "populates an array of foods when food.description like params:{'desc'}" do
        food1 = create(:food, name:'mie ayam', description:'ayam enak sekali')
        food2 = create(:food, name:'mie telor', description:'ayam mantap sekali')
        post :index, params:{"name"=>"", "desc"=>"enak", "min"=>"", "max"=>"","submit"=>"food"}
        expect(assigns(:foods)).to match_array([food1])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "submit food with minimun price" do
      it "populates an array of foods when food.price greater than params:{'min'}" do
        food1 = create(:food, name:'mie ayam', price:10000)
        food2 = create(:food, name:'mie telor', price:15000)
        post :index, params:{"name"=>"", "desc"=>"", "min"=>"13000", "max"=>"","submit"=>"food"}
        expect(assigns(:foods)).to match_array([food2])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "submit food with minimun price" do
      it "populates an array of foods when food.price less than params:{'max'}" do
        food1 = create(:food, name:'mie ayam', price:10000)
        food2 = create(:food, name:'mie telor', price:15000)
        post :index, params:{"name"=>"", "desc"=>"", "min"=>"", "max"=>"13000","submit"=>"food"}
        expect(assigns(:foods)).to match_array([food1])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
