class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum payment_type: {
    "Cash" => 0,
    "Go Pay" => 1,
    "Credit Card" => 2
  }

  validates :name, :address, :email, :payment_type, presence: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :payment_type, inclusion: payment_types.keys

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.reduce(0) { |sum, line_item| sum+line_item.total_price }
  end


end
