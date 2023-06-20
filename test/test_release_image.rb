# frozen_string_literal: true

require "test_helper"

describe ReleaseImage do
  it "generates image" do
    FileUtils.rm_rf("test/release_images/images")

    ReleaseImage.generate(version: "1.0.0")

    assert File.exist?("test/release_images/images/release_1_0_0.png")
  end

  it "requires version" do
    assert_raises ArgumentError do
      ReleaseImage::Generator.new
    end
  end
end
