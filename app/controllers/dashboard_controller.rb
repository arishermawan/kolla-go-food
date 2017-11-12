class DashboardController < ApplicationController
  def index
    @food_qty=Hash.new(0)
    @food_total = Hash.new(0)
    @res_total = Hash.new(0)
    @order_res = Hash.new { |h, k| h[k] = [] }
    LineItem.all.each do |line|
      if !line.order_id.nil?
        @food_total[line.food.name] += line.total_price
        @res_total[line.food.restaurant.name] += line.total_price
        @food_qty[line.food.name] += line.quantity
        @order_res[line.order_id] << line.food.restaurant.name if !@order_res[line.order_id].include?(line.food.restaurant.name)
      end
    end

    # @order_restaurant= Hash.new
    # Order.all.each do |order|
    #   res_array=[]
    #   order.line_items.each do |line|
    #     res_array << line.food.restaurant.name
    #   end
    #   @order_restaurant[order.id] = res_array.uniq
    # end
  end
end
