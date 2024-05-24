require_relative("link")
require_relative("property")
require_relative("logger")

module Oscal
  module OscalArray
    include ParsingLogger
    def input_is_array?(input)
      @logger.debug("#{self.class} checking to see if input was an Array.")
      unless input.is_a? Array
        raise InvalidTypeError,
              "#{self.class} must be an Array. Received #{input.class}."
      end
    end

    def validate_member_type(input)
      @logger.debug("Transforming Array elements to the expected type: #{self.class::MEMBER_TYPE}")
      input.map do |item|
        self.class::MEMBER_TYPE.new(item)
      end
    end

    def initialize(input)
      @logger = get_logger
      @logger.debug("#{self.class}.new called with #{input.to_s[0, 25]}")
      input_is_array?(input)
      validate_member_type(input)
    end
  end

  # A generic class for an Array of Tokens, which appears
  # several times in the specification
  class TokenArray
    include OscalArray
    MEMBER_TYPE = Token
  end

  class UuidArray
    include OscalArray
    MEMBER_TYPE = Uuid
  end

  module AssessmentResult
    class ActivityArray
      include OscalArray
      MEMBER_TYPE = Activity
    end

    class AssessmentPlatformArray
      include OscalArray
      MEMBER_TYPE = AssessmentPlatform
    end

    class AssessmentTaskArray
      include OscalArray
      MEMBER_TYPE = AssessmentTask
    end

    class AttestationArray
      include OscalArray
      MEMBER_TYPE = Attestation
    end

    class ComponentArray
      include OscalArray
      MEMBER_TYPE = Component
    end

    class ControlObjectiveSelectionArray
      include OscalArray
      MEMBER_TYPE = ControlObjectiveSelection
    end

    class ControlSelectionArray
      include Oscal::OscalArray
      MEMBER_TYPE = ControlSelection
    end

    class EntryArray
      include OscalArray
      MEMBER_TYPE = Entry
    end

    class ExcludeControlArray
      include OscalArray
      MEMBER_TYPE = ExcludeControl
    end

    class ExcludeObjectiveArray
      include OscalArray
      MEMBER_TYPE = ExcludeObjective
    end

    class FindingArray
      include OscalArray
      MEMBER_TYPE = Finding
    end

    class IncludeControlArray
      include OscalArray
      MEMBER_TYPE = IncludeControl
    end

    class InventoryItemArray
      include OscalArray
      MEMBER_TYPE = InventoryItem
    end

    class LinkArray
      include OscalArray
      MEMBER_TYPE = Oscal::Link
    end

    class ObjectivesAndMethodsArray
      include OscalArray
      MEMBER_TYPE = ObjectivesAndMethods
    end

    class ObservationArray
      include OscalArray
      MEMBER_TYPE = Observation
    end

    class PartArray
      include OscalArray
      MEMBER_TYPE = Link
    end

    class PartyUuidArray < UuidArray
    end

    class PropArray
      include OscalArray
      MEMBER_TYPE = Property
    end

    class ResponsibleRoleArray
      include OscalArray
      MEMBER_TYPE = ResponsibleRole
    end

    class ResultArray
      include OscalArray
      MEMBER_TYPE = Result
    end

    class RiskArray
      include OscalArray
      MEMBER_TYPE = Risk
    end

    class StatementIdArray < TokenArray
    end

    class StepArray
      include OscalArray
      MEMBER_TYPE = Step
    end

    class UserArray
      include OscalArray
      MEMBER_TYPE = User
    end
  end
end
