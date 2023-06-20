# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "release_image"

require "minitest/autorun"

# Get api key at:
# https://unsplash.com/oauth/applications

ReleaseImage.config.api_key     = "YOUR_API_KEY"
ReleaseImage.config.keywords    = %w[nature wallpaper]
ReleaseImage.config.folder_path = "test/release_image"
ReleaseImage.config.seasons     = true
