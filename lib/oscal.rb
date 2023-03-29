# frozen_string_literal: true

Dir[File.join(__dir__, 'oscal', '*.rb')].each { |file| require file }

module Oscal
  class Error < StandardError; end

  class UnknownAttributeError < Error; end
  class InvalidTypeError < Error; end
end
