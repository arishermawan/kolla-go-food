class Order < ApplicationRecord

  attr_accessor :voucher_code

  belongs_to :voucher, optional:true
  belongs_to :user
  has_many :line_items, dependent: :destroy

  enum payment_type: {
    "Cash" => 0,
    "Go Pay" => 1,
    "Credit Card" => 2
  }

  validates :name, :address, :email, :payment_type, presence: true
  validates :payment_type, inclusion: payment_types.keys
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates_with VoucherValidator
  validates_with GopayValidator
  validates_with LocationValidator

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def api_key
    api = 'AIzaSyAT3fcxh_TKujSW6d6fP9cUtrexk0eEvAE'
  end

  def get_google_api
    if !line_items.first.nil?
      gmaps = GoogleMapsService::Client.new(key: api_key)
      origins = line_items.first.food.restaurant.address
      destinations = address
      if !origins.empty? && !destinations.empty?
        matrix = gmaps.distance_matrix(origins, destinations, mode: 'driving', language: 'en-AU', avoid: 'tolls')
        matrix[:rows][0][:elements][0]
      end
    end
  end

  def distance
    if api_not_nil?
      if get_google_api[:status] == "OK"
        get_google_api[:distance][:value]
      end
    end
  end

  def delivery_cost
    if api_not_nil?
      cost = (distance.to_f / 1000) * 1500
      cost.round
    end
  end

  def sub_total
      total = line_items.reduce(0) { |sum, line_item| sum+line_item.total_price }
  end

  def sub_total_delivery
    if api_not_nil?
      sub_total + delivery_cost
    end
  end

  def discount
    discount = 0
    if voucher != nil
      dis = sub_total_delivery * voucher.amount / 100
      if voucher.unit_type == "% (Persentage)"
        dis < voucher.max_amount ? discount = dis : discount = voucher.max_amount
      elsif voucher.unit_type == "Rp (Rupiah)"
        voucher.amount < voucher.max_amount ? discount = voucher.amount : discount = voucher.max_amount
      end
    end
    discount.round
  end

  def total_price
    if api_not_nil?
      (sub_total_delivery - discount) < 0 ? 0 : sub_total_delivery - discount
    end
  end

  def reduce_gopay
    gopay =0
    if payment_type == "Go Pay"
      gopay = User.find(user_id).gopay
      gopay -= total
    end
    gopay
  end

  def api_not_nil?
    !get_google_api.nil?
  end
end
