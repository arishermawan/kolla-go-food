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
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :payment_type, inclusion: payment_types.keys
  validates_with VoucherValidator
  validates_with GopayValidator

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def sub_total
    line_items.reduce(0) { |sum, line_item| sum+line_item.total_price }
  end

  def self.get_location
    gmaps = GoogleMapsService::Client.new(key: 'AIzaSyAT3fcxh_TKujSW6d6fP9cUtrexk0eEvAE')
    origins = ["Kolla Sabang"]
      destinations = ["glodok, jakarta"]
      matrix = gmaps.distance_matrix(origins, destinations,
          mode: 'driving',
          language: 'en-AU',
          avoid: 'tolls')
  end




  def reduce_gopay
    gopay =0
    if payment_type == "Go Pay"
      gopay = User.find(user_id).gopay
      gopay -= total
    end
    gopay
  end


  def discount
    if voucher != nil
      dis = sub_total * voucher.amount / 100
      if voucher.unit_type == "Rp (Rupiah)"
        if voucher.amount < voucher.max_amount
          discount = voucher.amount
        else
          discount = voucher.max_amount
        end
      elsif voucher.unit_type == "% (Persentage)"
        if dis < voucher.max_amount
          discount = dis
        else
          discount = voucher.max_amount
        end
      end
    else
      0
    end
  end


  def total_price
    (sub_total - discount) < 0 ? 0 : sub_total - discount
  end
end
