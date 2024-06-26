# Release Image

![release_1_0_0](https://github.com/EffectivaStudio/release_image/assets/66572/e73724ee-3da7-4769-adcf-cdf26816d9d0)

The Release Image gem is a simple tool designed specifically to help create cover images for release posts or notices within your application. It makes it easy to include essential elements like your app's logo, version, and release date in the images. It also lets you pick from a large collection of images from [Unsplash](https://unsplash.com/) service.

## Features

- 🌟 Effortlessly create stunning cover images for release posts or notices
- 🌟 Seamlessly integrate your app's logo, version, and release date into the images
- 🌟 Utilize the vast collection of Unsplash to obtain random images
- 🌟 Customize various aspects of the image generation process

Enjoy creating eye-catching and unique cover images for your release posts with the Release Image gem!

## Installation

Add this line to your application's Gemfile:

```ruby
  gem "release_image", require: false, group: :development
```

## Usage

Example `bin/release_image` script:

```rb
#!/usr/bin/env ruby

require "dotenv/load"
require "optparse"
require "colorize"
require "release_image"

APP_ROOT = File.expand_path("..", __dir__)

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: bin/release_image version [date] [options]"

  opts.on("--skip-download", "Skip downloading a random image and use a previously downloaded image instead.") do
    options[:skip_download] = true
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

# Get api key at:
# https://unsplash.com/oauth/applications
#
# keywords - An array of keywords that can be used to filter the random image
# folder_path - The destination folder where the generated images will be saved
# logo_path - The path to your app's logo image
# seasons - Generate images based on the current season of the year

ReleaseImage.config.api_key     = ENV.fetch("UNSPLASH_API_KEY")
ReleaseImage.config.keywords    = %w[nature wallpaper]
ReleaseImage.config.folder_path = File.join(APP_ROOT, "tmp/release_image")
ReleaseImage.config.logo_path   = File.join(APP_ROOT, "app/assets/images/logo/release_logo.png")
ReleaseImage.config.seasons     = true

version = ARGV[0]
date    = ARGV[1]

abort("Please provide a release version".red) unless version

puts ReleaseImage.generate(version: version, date: date, skip_download: options[:skip_download]).green
```

### Use existing image

Sometimes you may want to skip downloading a random image and use a previously downloaded image instead. This can be
achieved by setting the `skip_download` option to `true`. Image is downloaded by default and saved to the `folder_path`
directory as `image.jpg`.

```rb
ReleaseImage.generate(version: version, date: date, skip_download: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/EffectivaStudio/release_image. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/EffectivaStudio/release_image/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Release Image project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/EffectivaStudio/release_image/blob/main/CODE_OF_CONDUCT.md).
