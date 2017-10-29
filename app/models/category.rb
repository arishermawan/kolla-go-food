class Category < ApplicationRecord
  has_many :foods
  validates :name, uniqueness: true, presence: true
  
end
