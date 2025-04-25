Cloudinary.config do |config|
    config.cloud_name = 'Rails.application.credentials.dig(:cloudinary, :name)'
    config.api_key = Rails.application.credentials.dig(:cloudinary, :key)
    config.api_secret = Rails.application.credentials.dig(:cloudinary, :secret)
    # config.secure = true
    # config.cdn_subdomain = true
end