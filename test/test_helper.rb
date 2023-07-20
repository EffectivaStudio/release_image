# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "dotenv/load"
require "release_image"

require "minitest/autorun"
require "mocha/minitest"

require 'open3'


# Get api key at:
# https://unsplash.com/oauth/applications

ReleaseImage.config.api_key     = ENV.fetch("UNSPLASH_API_KEY")
ReleaseImage.config.keywords    = %w[nature wallpaper]
ReleaseImage.config.folder_path = "test/images"
ReleaseImage.config.logo_path   = "test/fixtures/logo.png"
ReleaseImage.config.seasons     = true

# Compare two images and raise exception if they are not equal
# compare is a command line tool from ImageMagick
# https://imagemagick.org/script/compare.php
def compare_images p1, p2, show_diff: false
  diff_path = '/dev/null'
  diff_path = 'test/images/diff.png' if show_diff
  # This will produce output: 16061.8 (0.245088)
  # The last number if score
  _stdout, stderr = Open3.capture3("compare -alpha deactivate -metric RMSE #{p1} #{p2} #{diff_path}")

  score = stderr[/\((\d(?:\.\d+)?)\)/, 1]

  raise "Compare failed: #{stderr}. Extracted score: #{score}" unless score

  score.to_f
end


def assert_images_equal p1, p2, within: 0.05, show_diff: true
  score = compare_images p1, p2, show_diff: show_diff

  assert score < within, "Images are not equal. Score: #{score} should be below #{within}"
end