class Cart < ApplicationRecord
  has_many  :line_items, dependent: :destroy

  def add_food(food)
    current_item = line_items.find_by(food_id: food.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(food_id: food.id)
    end
    current_item
  end

  def self.total_price(cart)
    total=0
    cart.line_items.each do |item|  
      total += item.quantity * item.food.price
    end
    total
  end

end
