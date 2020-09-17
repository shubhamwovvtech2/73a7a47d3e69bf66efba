json.extract! follow, :id, :followed_by_id, :following_id, :created_at, :updated_at
json.url follow_url(follow, format: :json)
