class Voucher < ApplicationRecord
  attr_accessor :voucher_code
  has_many :orders

  enum unit_type: {
    "Rp (Rupiah)" => 0,
    "% (Persentage)" => 1
  }

  validates :code, presence: true, uniqueness: {case_senstitive: false}
  validates :valid_from, :valid_through, presence: true
  validates :amount, :max_amount, numericality: { greater_than_or_equal_to: 0.01 }
  validates :unit_type, presence: true, inclusion: unit_types.keys
  validates_with DateValidator
  validates_with AmountValidator


  before_save :ensure_code_upcase
  before_update :ensure_code_upcase
  before_destroy :ensure_not_referenced_by_any_order

  private
    def ensure_not_referenced_by_any_order
      unless orders.empty?
        errors.add(:base, 'Order present')
        throw :abort
      end
    end

    def ensure_code_upcase
      code.upcase!
    end
end
