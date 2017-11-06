class Voucher < ApplicationRecord
  has_many :order

  enum unit_type: {
    "% (Persentage)" => 1,
    "Rp (Rupiah)" => 0
  }

  validates :code, presence: true, uniqueness: true
  validates :valid_from, :valid_through, presence: true
  validates :amount, :max_amount, numericality: { greater_than_or_equal_to: 0.01 }
  validates :unit_type, inclusion: unit_types.keys




end
