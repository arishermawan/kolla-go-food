json.extract! user, :id, :name, :description, :image_url, :price, :created_at, :updated_at
json.url user_url(user, format: :json)
