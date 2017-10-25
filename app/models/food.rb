class Food < ApplicationRecord
  validates :name, :description, presence: true
  validates :image_url 
end
