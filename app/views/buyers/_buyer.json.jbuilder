json.extract! buyer, :id, :email, :name, :phone, :address, :created_at, :updated_at
json.url buyer_url(buyer, format: :json)
