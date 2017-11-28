class RestaurantValidator < ActiveModel::Validator
  def validate(record)
    if !record.cart.line_items.nil?
      if record.cart.line_items.first.food.restaurant_id != record.food.restaurant_id
        record.errors[:base] << "can't add food from different restaurant"
      end
    end
  end
end
