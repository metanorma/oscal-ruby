# frozen_string_literal: true

require_relative "oscal/version"
require_relative "oscal/serializer"
require_relative "oscal/catalog"
require_relative "oscal/component"
require_relative "oscal/control"
require_relative "oscal/group"
require_relative "oscal/part"
require_relative "oscal/parameter"
require_relative "oscal/metadata_block"
require_relative "oscal/profile"
require_relative "oscal/property"
require_relative "oscal/prose"
require_relative "oscal/statement"

module Oscal
  class Error < StandardError; end

  class UnknownAttributeError < Error; end
  class InvalidTypeError < Error; end
end
