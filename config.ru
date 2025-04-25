# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

# Replace the 'config_from_url' string value below with your
# product environment's credentials, available from your Cloudinary console.
# =====================================================

# require 'cloudinary'

# Cloudinary.config_from_url(Rails.application.credentials.dig(:cloudinary, :url))

run Rails.application
Rails.application.load_server
