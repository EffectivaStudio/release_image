# frozen_string_literal: true

require "test_helper"

describe ReleaseImage do
  it "generates image" do
    FileUtils.rm_rf("test/release_image")

    ReleaseImage.generate(version: "1.0.0")

    assert File.exist?("test/images/release_1_0_0.png")
  end

  it "requires version" do
    assert_raises ArgumentError do
      ReleaseImage::Generator.new
    end
  end
end

describe ReleaseImage::Generator do
  it "adds text and logo to image" do
    generator = ReleaseImage::Generator.new(version: "1.0.0", date: "21.06.2023")

    image_path = "test/fixtures/input_image.png"
    release_image_path = "test/images/output_image.png"

    generator.stubs(
      download_image: true,
      image_path: image_path,
      release_image_path: release_image_path
    )

    generator.generate

    expected_image_path = "test/fixtures/output_image.png"

    assert_images_equal(expected_image_path, release_image_path)
  end
end
