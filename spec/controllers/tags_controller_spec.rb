require 'rails_helper'

describe TagsController do

  describe 'GET #index' do

    it "populates an array of all tags" do
      tag1 = create(:tag, name:'fastfood')
      tag2 = create(:tag, name:'streetfood')
      get :index
      expect(assigns(:tags)).to match_array([tag1, tag2])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do

    it "assigns the requested tag to @tag" do
      tag = create(:tag)
      get :show, params:{id: tag}
      expect(assigns(:tag)).to eq tag
    end

    it "renders the :show template" do
      get :show, params:{id: tag}
      expect(response).to render_template :show
    end

  end

  describe 'GET #new' do

    it "assign the new tag to @tag" do
      get :new
      expect(assigns(:tag)).to be_a_new(Tag)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end

  end

  describe 'POST #create' do

    context "with valid attributes" do
      it "save new tag in the database" do
        expect{
          post :create, params:{ tag: attributes_for(:tag) }
        }.to change(Tag, :count).by(1)
      end

      it "redirect to tag#show" do
        post :create, params:{ tag: attributes_for(:tag) }
        expect(response).to redirect_to(tag_path(assigns[:tag]))
      end
    end

    context "with invalid attributes" do
      it "doesn't save new tag in the database" do
        expect{
            post :create, params:{ tag: attributes_for(:tag) }
          }.not_to change(Tag, :count)
      end

      it "re-render the :new template" do
        post :create, params:{ tag: attributes_for(:tag) }
        expect(response).to render_template :new
      end
    end

  end

  describe 'GET #edit' do
    it "assigns the a new tag to @tag" do
      tag = create(:tag)
      get :edit, params:{ id: tag }
      expect(assigns(:tag)).to eq(tag)
    end

    it "renders the :edit template" do
      tag = create(:tag)
      get :edit, params:{ id: tag }
      expect(response).to render_tempalte :edit
    end
  end

  describe 'PATCH #update' do
    before :each do
      @tag = create(:tag)
    end

    context "with valid attributes" do
      it "located the requested @tag" do
        patch :update, params:{id: @tag, tag: attributes_for(:tag)}
        expect(assigns(:tag)).to eq @tag
      end

      it "changes the tag attributes" do
        patch :update, params:{id: @tag, tag: attributes_for(:tag, name:"junkfood")}
        @tag.reload
        expect(@tag.name).to eq("junkfood")
      end

      it "redirect to tag#show" do
        patch :update, params:{id: @tag, tag: attributes_for(:tag, name:"junkfood")}
        expect(response).to renders_template :show
      end
    end

    context "with invalid attributes" do
      it "doesn't update new tag in the database" do
        patch :update, params:{id: @tag, tag: attributes_for(:invalid_tag)}
        @tag.reload
        expect(@tag.name).not_to eq(nil)
      end
      it "re-render the :edit template" do
        patch :update, params:{id: @tag, tag: attributes_for(:invalid_tag)}
        expect(response).to render_template :edit
      end

    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @tag = create(:tag)
    end
    context "doesn't have association with food" do
      it "delete the tag from database" do
        expect{
          delete :destroy, params:{id: @tag}
        }.to change(Tag, :count).by(-1)
      end

      it "redirect to the tag#index" do
        delete :destroy, params:{id: @tag}
        expect(response).to redirect_to tags_path
      end
    end

    context "have association with food" do
      food = create(:food, tag: @tag)
      it "dont delete the tag from database" do
        expect{
          delete :destroy, params:{id: @tag}
        }.not_to change(Tag, :count)
      end

      it "redirect to the tag#index" do
        delete :destroy, params:{id: @tag}
        expect(response).to redirect_to tags_path
      end
    end
  end

end
