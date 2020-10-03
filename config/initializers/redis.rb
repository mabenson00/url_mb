if Rails.env == "test"
  REDIS = Redis.new(db: 0)
elsif Rails.env == "development"
  REDIS = Redis.new(db: 1)
else 
  # production redis
end 

