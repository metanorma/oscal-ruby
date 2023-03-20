# frozen_string_literal: true

require_relative "lib/oscal/version"

Gem::Specification.new do |spec|
  spec.name = "oscal"
  spec.version = Oscal::VERSION
  spec.authors = ["Ronald Tse"]
  spec.email = ["ronald.tse@ribose.com"]

  spec.summary = "Interact with OSCAL models"
  spec.description = "Ruby library and parser for OSCAL models"
  spec.homepage = "https://github.com/metanorma/oscal-ruby/"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/metanorma/oscal-ruby/"
  spec.metadata["changelog_uri"] = "https://github.com/metanorma/oscal-ruby/CHANGELOG"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "yaml"
end
