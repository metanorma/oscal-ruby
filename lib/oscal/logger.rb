module Oscal
  module ParsingLogger
    require "logger"
    def self.logger=(value)
      @@logger = value
    end

    def get_logger
      @@logger ||= Logger.new($stdout)
    end
  end
end
