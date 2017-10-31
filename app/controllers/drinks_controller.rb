class DrinksController < ApplicationController
  
  def index
    @drinks = params[:letter].nil? ? Drink.all : Drink.by_letter(params[:letter])
  end

  def show
    @drink = Drink.find(params[:id])
  end

  def edit
    @drink = Drink.find(params[:id])
  end

  def create
    @drink = Drink.new(drink)
    respond_to do |format|
      if @drink.save
        format.html { redirect_to @drink, notice: 'Drink was successfully created.' }
        format.json { render :show, status: :created, location: @drink }
      else
        format.html { render :new }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @drink = Drink.find(params[:id])
    respond_to do |format|
      if @drink.update(drink_params)
        format.html { redirect_to @drink, notice: 'Drink was successfully created.' }
        format.json { render :show, status: :ok, location: @drink }
      else
        format.html { render :edit }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end



  private
    

    def drink_params
      params.require(:drink).permit(:name, :description, :image_url, :price, :category_id)
    end

end
