class Restaurant < ApplicationRecord
  has_many :foods
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true


  before_destroy :ensure_not_referenced_by_any_food

  private
    def ensure_not_referenced_by_any_food
      unless foods.empty?
        errors.add(:base, 'Foods present')
        throw :abort
      end
    end


end
