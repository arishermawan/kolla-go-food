class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_url, :created_at, :updated_at
  belongs_to :category
  belongs_to :restaurant
end
