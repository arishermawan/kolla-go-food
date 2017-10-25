class Food < ApplicationRecord
  validates :name, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png|)\z}i,
    message: 'must be a URL for GIF, JPG, or PNG Image.'
  }
end
