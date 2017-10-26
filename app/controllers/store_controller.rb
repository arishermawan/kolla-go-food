class StoreController < ApplicationController
  def index
    @foods = Food.order(:name) # ({name: :desc})
  end
end
