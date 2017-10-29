class LineItem < ApplicationRecord
  belongs_to :food
  belongs_to :cart

  def self.total_price(qty, price)
    qty * price
  end

end
