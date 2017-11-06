class Voucher < ApplicationRecord
  attr_accessor :voucher_code
  has_many :orders

  enum unit_type: {
    "Rp (Rupiah)" => 0,
    "% (Persentage)" => 1
    
  }

  validates :code, presence: true, uniqueness: true
  validates :valid_from, :valid_through, presence: true
  validates :amount, :max_amount, numericality: { greater_than_or_equal_to: 0.01 }
  validates :unit_type, inclusion: unit_types.keys

  before_save :ensure_code_upcase
  before_update :ensure_code_upcase

  def ensure_code_upcase
    if code != code.upcase
      code.upcase!
    end
  end

  def voucher_code
  end

end
