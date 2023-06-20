# Release Image

![release_1_0_0](https://github.com/EffectivaStudio/release_image/assets/66572/fd734af3-67a7-400e-8523-d507ed349dba)

## Installation

TODO: Replace `release_image` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add release_image

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install release_image

## Usage

Example `bin/release_image` script:

```rb
#!/usr/bin/env ruby

require 'dotenv/load'
require "colorize"
require "release_image"

APP_ROOT = File.expand_path('..', __dir__)

# Get api key at:
# https://unsplash.com/oauth/applications
#
# Keywords are used to search for images.
# Folder path is where the generated image will be saved.
# Seasons are used to generate a season specific image by adding the actual
# season (Spring, Summer, Autumn, or Winter) to the keywords.

ReleaseImage.config.api_key     = ENV.fetch("UNSPLASH_API_KEY")
ReleaseImage.config.keywords    = %w[nature wallpaper]
ReleaseImage.config.folder_path = File.join(APP_ROOT, "release_image")
ReleaseImage.config.seasons     = true

version = ARGV[0]
date    = ARGV[1]

abort("Please provide a release version".red) unless version

puts ReleaseImage.generate(version: version, date: date).green
```

**Note**
Add the logo image to the specified `<folder_path>`.
Name the image `logo.png` and it will be added to the generated image.
Add `<folder_path>/images/` to your `.gitignore` file.
No need to add the generated image to git repo.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/release_image. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/release_image/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ReleaseImage project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/release_image/blob/main/CODE_OF_CONDUCT.md).
