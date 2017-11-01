class Order < ApplicationRecord
  enum payment_type: {
    "Cash" => 0,
    "Go Pay" => 1,
    "Credit Card" => 2
  }
  validates :name, :address, :email, :payment_type, presence: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :payment_type, inclusion: payment_types.keys


end
