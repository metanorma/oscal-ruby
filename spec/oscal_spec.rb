# frozen_string_literal: true

RSpec.describe Oscal do
  it "has a version number" do
    expect(Oscal::VERSION).not_to be nil
  end

  it "allows setting a new logger" do
    logger = double(Logger)
    Oscal::ParsingLogger.logger = logger

    class LoggerTest
      include Oscal::ParsingLogger
    end

    expect(LoggerTest.new.get_logger).to eq logger
  end
end
