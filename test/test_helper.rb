# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "dotenv/load"
require "release_image"

require "minitest/autorun"
require "mocha/minitest"

# Get api key at:
# https://unsplash.com/oauth/applications

ReleaseImage.config.api_key     = ENV.fetch("UNSPLASH_API_KEY")
ReleaseImage.config.keywords    = %w[nature wallpaper]
ReleaseImage.config.folder_path = "test/images"
ReleaseImage.config.logo_path   = "test/fixtures/logo.png"
ReleaseImage.config.seasons     = true
