# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

# Note:
#
# There seems to be lots of issue with the current rubocop rules
# We are commenting this out for the moment, so instead of fixing
# those right away, we can focus on the new codes and then later
# come back to this and fix the issues.
#
# require "rubocop/rake_task"
# RuboCop::RakeTask.new
#
# task default: %i[spec rubocop]

RSpec::Core::RakeTask.new(:spec)
task default: :spec
