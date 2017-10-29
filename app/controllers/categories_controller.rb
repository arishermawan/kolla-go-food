class CategoriesController < ApplicationController
  # before_action :set_category, only: [:show, :edit, :update, :destroy]
  def show
    @category = Category.find(params[:id])
    @foods= Food.where(category_id: params[:id] )
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end


  def create

    @category = Category.new(food_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(food_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if category_empty?(@category)
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category was not empty.' }
      end
    end

  end

  private

  def category_empty?(category)
    category.foods.length == 0
  end

  def food_params
    params.require(:category).permit(:name)
  end

end
