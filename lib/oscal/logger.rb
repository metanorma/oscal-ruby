module Oscal
  module ParsingLogger
    require "logger"
    def get_logger
      Logger.new($stdout)
    end
  end
end
