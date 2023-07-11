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

    generator.stubs(
      download_image: true,
      image_path: "test/fixtures/input_image.jpg",
      release_image_path: "test/images/output_image.png"
    )

    generator.generate

    expected_image = File.open("test/fixtures/output_image.png", "rb")
    actual_image   = File.open("test/images/output_image.png", "rb")

    assert_equal expected_image.read.bytes, actual_image.read.bytes

    expected_image.close
    actual_image.close

    FileUtils.rm("test/images/output_image.png")
  end
end
