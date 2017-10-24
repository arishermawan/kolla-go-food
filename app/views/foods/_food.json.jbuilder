json.extract! food, :id, :name, :description, :image_url, :price, :created_at, :updated_at
json.url food_url(food, format: :json)
