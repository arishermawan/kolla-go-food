class Buyer < ApplicationRecord
  validates :email, :name, :phone, :address, presence: true
  validates :email, uniqueness: true
  validates :phone, numericality: { only_integer: true }, length: { minimum: 5, maximum:12 }
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  def self.by_letter(letter)
    where("name LIKE ?","#{(letter)}%").order(:name)
  end



end
