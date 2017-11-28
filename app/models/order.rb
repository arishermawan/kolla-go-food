class Order < ApplicationRecord

  attr_accessor :voucher_code

  has_many :line_items, dependent: :destroy

  belongs_to :voucher, optional:true
  belongs_to :user

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

  before_save :total_price, :discount, :delivery_cost
  after_save :reduce_gopay
  # after_save :User.find(order.user_id).update(gopay: order.reduce_gopay)

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

  def cost_per_km
    1500
  end

  def delivery_cost
    cost = 0
    if api_not_nil?
      cost = (distance.to_f / 1000) * cost_per_km
    end
    self.delivery_cost = cost.round
  end

  def sub_total
    sub_total = line_items.reduce(0) { |sum, line_item| sum+line_item.total_price }
    self.sub_total = sub_total
  end

  def sub_total_delivery
    delivery = 0
    if api_not_nil?
      delivery = sub_total + delivery_cost
    end
    delivery
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
    self.discount = discount.round
  end

  def total_price
    total = 0
    if api_not_nil?
      (sub_total_delivery - discount) < 0 ? total = 0 : total = sub_total_delivery - discount
    end
    self.total = total
  end

  def reduce_gopay
    if payment_type == "Go Pay"
      user = User.find(user_id)
      gopay = user.gopay
      gopay -= total
      user.update(gopay: gopay)
    end
  end

  def api_not_nil?
    !get_google_api.nil?
  end
end
