json.array!(@posts) do |post|
  json.extract! post, :id, :zip_code, :title, :description, :category_id, :user_id, :contractor_id
  json.url post_url(post, format: :json)
end
