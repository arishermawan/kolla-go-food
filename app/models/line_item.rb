class LineItem < ApplicationRecord
  belongs_to :food
  belongs_to :cart

  def self.total_price(item)
    item.quantity * item.food.price
  end

end
