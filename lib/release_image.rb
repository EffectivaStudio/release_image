# frozen_string_literal: true

require "mini_magick"
require "down"
require "fileutils"
require "pathname"

require_relative "release_image/version"

module ReleaseImage
  class Error < StandardError; end

  class Config
    attr_accessor :api_key, :folder_path, :logo_path, :keywords, :seasons

    def initialize
      @api_key = nil
      @folder_path = nil
      @logo_path = nil
      @keywords = []
      @seasons = true
    end
  end

  class Generator
    BASE_URL = "https://api.unsplash.com/photos/random"

    def initialize(version:, date: nil, skip_download: false)
      @version = version
      @date    = date ? Date.parse(date) : Date.today

      @skip_download = skip_download

      @folder_path = ReleaseImage.config.folder_path
      @logo_path   = ReleaseImage.config.logo_path
      @keywords    = ReleaseImage.config.keywords
      @api_key     = ReleaseImage.config.api_key
      @seasons     = ReleaseImage.config.seasons
    end

    def generate
      create_folder
      download_image unless @skip_download
      create_release_image
    end

    def create_folder
      FileUtils.mkdir_p(@folder_path) unless File.directory?(@folder_path)
    end

    def download_image
      uri = URI(url)
      response = Net::HTTP.get_response(uri)

      data = JSON.parse(response.body)
      image_url = data["urls"]["regular"]
      image = Down.download(image_url)
      File.binwrite(image_path, image.read)
    end

    def create_release_image
      image = MiniMagick::Image.open(image_path)

      resize_image(image)
      add_background_and_text(image)
      result = add_logo(image)

      result.write release_image_path

      release_image_path
    end

    def release_image_path
      underscored_version = @version.tr(".", "_")
      "#{@folder_path}/release_#{underscored_version}.png"
    end

    def resize_image(image)
      image.resize "1920x1200^"
      image.gravity "center"
      image.extent "1920x1200"
    end

    def add_background_and_text(image) # rubocop:disable Metrics/MethodLength
      image.combine_options do |cmd|
        cmd.geometry "+0+0"
        cmd.gravity "center"

        cmd.fill "rgba(0, 0, 0, 0.5)"
        cmd.draw "rectangle 0,0 #{image.width},#{image.height}"

        cmd.fill "white"
        cmd.font "Helvetica"

        cmd.pointsize 80
        cmd.draw "text 0, -100 'v#{@version}'"

        cmd.pointsize 60
        cmd.draw "text 0, -10 '#{@date.strftime("%d. %B %Y.")}'"
      end
    end

    def add_logo(image)
      logo = MiniMagick::Image.open(@logo_path)

      image.composite(logo) do |c|
        c.geometry "+#{(image.width / 2) - (logo.width / 2)}+300"
      end
    end

    def image_path
      "#{@folder_path}/image.jpg"
    end

    def url
      "#{BASE_URL}?query=#{query}&client_id=#{@api_key}"
    end

    def query
      result = @keywords
      result += [season] if @seasons
      result.join(" ")
    end

    def season
      case @date.strftime("%m").to_i
      when 3..5  then "Spring"
      when 6..8  then "Summer"
      when 9..11 then "Autumn"
      else "Winter"
      end
    end

    def api_key
      ReleaseImage.config.api_key
    end
  end

  def self.config
    @config ||= ReleaseImage::Config.new
  end

  def self.generate(version:, date: nil, skip_download: false)
    Generator.new(version: version, date: date, skip_download: skip_download).generate
  end
end
