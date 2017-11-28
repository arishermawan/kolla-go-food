class LineItem < ApplicationRecord
  belongs_to :food
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  # validates_with RestaurantValidator

  def total_price
    quantity * food.price
  end

end
