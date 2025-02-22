json.extract! product, :id, :title, :description, :price, :size, :contact_info, :url, :last_fetched_at, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
