class Category < ApplicationRecord
  has_many :foods
  validates :name, uniqueness: true, presence: true

  def self.category_empty?(category)
    category.foods.length == 0
  end
  
  def self.by_category(id)
    Food.where(category_id: id)
  end

end
