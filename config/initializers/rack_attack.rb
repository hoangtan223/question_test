Rack::Attack.throttle('limit request per tenant', limit: 1, period: 10) do |req|
  MAX_DAILY_REQUEST = 100
  api_key = req.env['HTTP_API_KEY']
  data = Rails.cache.read("tenant-#{api_key}")
  if data.present? && data[:date] == Date.current
    count = data[:count]
    if count >= MAX_DAILY_REQUEST
      api_key
    else
      Rails.cache.write("tenant-#{api_key}", { date: Date.current, count: count + 1 })
      nil
    end
  else
    Rails.cache.write("tenant-#{api_key}", { date: Date.current, count: 1})
    nil
  end
end
