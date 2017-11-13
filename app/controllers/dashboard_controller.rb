class DashboardController < ApplicationController
  def index
    @order_sum = Hash.new(0)
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
        @order_sum[line.order.created_at.to_date] += line.total_price
      end
    end

    max_date = @order_sum.max_by{ |k,v| k}.first
    min_date = @order_sum.min_by{ |k,v| k}.first
    (min_date..max_date).each do |day|
      @order_sum[day]=0 if !@order_sum.keys.include?(day)
    end
    @restaurant_order_count = Hash.new(0)
    @order_res.each do |k,v|
      v.each do |a|
        @restaurant_order_count[a] += 1
      end
    end
  end
end
