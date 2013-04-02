json.array!(@posts) do |post|
  json.extract! post, :title, :content, :published_at, :status
  json.url post_url(post, format: :json)
end