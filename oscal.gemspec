# frozen_string_literal: true

require_relative "lib/oscal/version"

Gem::Specification.new do |spec|
  spec.name = "oscal"
  spec.version = Oscal::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com"]

  spec.summary = "Interact with OSCAL models"
  spec.description = "Ruby library and parser for OSCAL models"
  spec.homepage = "https://github.com/metanorma/oscal-ruby/"
  spec.license = "BSD-2-Clause"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/metanorma/oscal-ruby/"
  spec.metadata["changelog_uri"] = "https://github.com/metanorma/oscal-ruby/CHANGELOG"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- exe/*`.split("\n").map do |f|
    File.basename(f)
  end
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.add_dependency "yaml"
  spec.metadata["rubygems_mfa_required"] = "true"
end
