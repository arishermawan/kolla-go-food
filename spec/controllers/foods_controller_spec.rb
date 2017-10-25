require 'rails_helper'

describe FoodsController do
  describe 'GET #index' do
    context 'with params[:letter]' do
      it "populates an array of foods starting with the letter"
      it "render the :index template"
    end

    context 'without params[:letter]' do
      it "populates an array of all foods"
      it "render the :index template"
    end
  end

  describe 'GET #show' do
    it "assigns the requested food to @food"
    it "render the :show template"
  end

  describe 'GET #new' do
    it "assigns a new Food to @food"
    it "render the :new template"
  end

  describe 'GET #edit' do
    it "assigns a new Food to @food"
    it "render the :edit template"
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "save the new food in the database"
      it "redirects to food#show"
    end

    context 'with invalid attributes' do
      it "does not save the new food in the database"
      it "re-render the :new template"
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it "locates the requested @food"
      it "changes @food's attributes"
      it "redirects to the food"
    end

    context 'with invalid attributes' do
      it "does not update the food in the database"
      it "re-render the :edit template"
    end
  end

  describe 'DELETE #destroy' do
    it "delete the food from the database"
    it "redirects to the food#index"
  end

end