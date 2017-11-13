class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize

  def index
    # @foods = Food.order(:name) # ({name: :desc})
     @restaurants = Restaurant.all 
  end
end
