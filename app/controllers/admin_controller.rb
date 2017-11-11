class AdminController < ApplicationController
  def index


    if params[:submit].present?
      if params[:submit] == "food"
        fmax = params[:max]
        if fmax == ""
          fmax = Food.maximum(:price)
        else
          fmax = fmax.to_i
        end

        @foods = Food.where('name LIKE ?', "%#{params[:name]}%").where('description LIKE ?', "%#{params[:desc]}%").where('price >= ?', params[:min].to_i).where('price <= ?', fmax)
      elsif params[:submit]=="order"
        fmax = params[:max]
        if fmax == ""
          fmax = Order.maximum(:total)
        else
          fmax = fmax.to_i
        end

        if params[:payment] ==""
          @orders = Order.where('name LIKE ?', "%#{params[:name]}%").where('address LIKE ?', "%#{params[:address]}%").where('email LIKE ?', "%#{params[:email]}%").where('total >= ?', params[:min].to_i).where('total <= ?', fmax)
        else
          @orders = Order.where('name LIKE ?', "%#{params[:name]}%").where('address LIKE ?', "%#{params[:address]}%").where('email LIKE ?', "%#{params[:email]}%").where('total >= ?', params[:min].to_i).where('total <= ?', fmax).where('payment_type == ?', params[:payment].to_i)
        end
      elsif params[:submit]=="restaurant"
        fmax = params[:max]
        if fmax == ""
          @restaurants = Restaurant.joins(:foods).group(:restaurant_id).having("count(*)>=?", params[:min].to_i).where('restaurants.name LIKE ?', "%#{params[:name]}%").where('restaurants.address LIKE ?', "%#{params[:address]}%")
        else
          @restaurants = Restaurant.joins(:foods).group(:restaurant_id).having("count(*)>=? AND count(*)<=?", params[:min].to_i, params[:max].to_i ).where('restaurants.name LIKE ?', "%#{params[:name]}%").where('restaurants.address LIKE ?', "%#{params[:address]}%")
        end
      end
    end
  end

    def food_params
      params.require(:food).permit(:name, :description, :image_url, :price, :category_id, :restaurant_id, :term, tag_ids:[])
    end
end
