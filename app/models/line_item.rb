class LineItem < ApplicationRecord
  belongs_to :food
  belongs_to :cart

  def total_price
    quantity * food.price
  end

end
