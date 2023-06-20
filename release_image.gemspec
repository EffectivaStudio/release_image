# frozen_string_literal: true

require_relative "lib/release_image/version"

Gem::Specification.new do |spec|
  spec.name = "release_image"
  spec.version = ReleaseImage::VERSION
  spec.authors = ["Effectiva studio"]
  spec.email = ["info@effectiva.hr"]
  spec.summary = "Generate random image for release"
  spec.description = "It genrates a random image for release using Unsplash API"
  spec.homepage = "https://github.com/EffectivaStudio/release_image"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/effectivastudio"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/EffectivaStudio/release_image"
  spec.metadata["changelog_uri"] = "https://github.com/EffectivaStudio/release_image/blob/main/CHANGELOG"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "down"
  spec.add_dependency "mini_magick"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
