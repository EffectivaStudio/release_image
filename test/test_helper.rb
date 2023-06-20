# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "release_image"

require "minitest/autorun"

ReleaseImage.config.api_key     = "BuncfOWT8XmQM2D42NqyNl_VWL3StgacRRrculTJsqs"
ReleaseImage.config.keywords    = %w[nature wallpaper]
ReleaseImage.config.folder_path = "test/release_images"
