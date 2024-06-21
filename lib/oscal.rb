# frozen_string_literal: true

Dir[File.join(__dir__, "oscal", "*.rb")].each { |file| require file }

module Oscal
  class Error < StandardError; end

  class UnknownAttributeError < Error; end
  class InvalidTypeError < Error; end

  def self.root_path
    @root_path ||= Pathname.new(File.dirname(__dir__))
  end
end
