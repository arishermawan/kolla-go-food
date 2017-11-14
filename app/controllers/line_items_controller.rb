class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  skip_before_action :authorize, only: :create

  def create
    food = Food.find(params[:food_id])
    @line_item = @cart.add_food(food)

    respond_to do |format|

      if @cart.line_items.nil?
        if @line_item.save
          format.html {redirect_to store_index_url, notice: 'Line item was successfully'}
          format.js {@current_item = @line_item}
          format.json {render :show, status: :created, location: @line_item}
        else
          format.html { render :new }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      else
        if @cart.line_items.first.food.restaurant_id == food.restaurant_id
          if @line_item.save
            format.html {redirect_to store_index_url, notice: 'Line item was successfully'}
            format.js {@current_item = @line_item}
            format.json {render :show, status: :created, location: @line_item}
          else
            format.html { render :new }
            format.json { render json: @line_item.errors, status: :unprocessable_entity }
          end
        else
          format.html {redirect_to store_index_url, notice: 'cannot add food with different restaurant'}
        end
      end
    end
  end
end
