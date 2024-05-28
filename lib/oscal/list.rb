require_relative("link")
require_relative("property")
require_relative("logger")

module Oscal
  class OscalArray < Array
    include ParsingLogger

    def validate_member_type(input)
      @logger.debug("Validating array members are #{self.class::MEMBER_TYPE}")
      input.map do |item|
        self.class::MEMBER_TYPE.new(item)
      end
    end

    def initialize(input)
      super
      @logger = get_logger
      @logger.debug("#{self.class}.new called with #{input.to_s[0, 25]}")
      validate_member_type(input)
    end
  end

  # These classes define generic arrays of basic DataTypes,
  # They appear in several different places in the Oscal specs
  # and can be subclassed with a different name
  class StringDataTypeArray < Oscal::OscalArray
    MEMBER_TYPE = StringDataType
  end

  class TokenDataTypeArray < Oscal::OscalArray
    MEMBER_TYPE = TokenDataType
  end

  class UuidArray < Oscal::OscalArray
    MEMBER_TYPE = Uuid
  end

  module AssessmentResult
    class ActivityArray < Oscal::OscalArray
      MEMBER_TYPE = Activity
    end

    class AssessmentPlatformArray < Oscal::OscalArray
      MEMBER_TYPE = AssessmentPlatform
    end

    class AssessmentTaskArray < Oscal::OscalArray
      MEMBER_TYPE = AssessmentTask
    end

    class AssociatedActivityArray < Oscal::OscalArray
      MEMBER_TYPE = AssociatedActivity
    end

    class AttestationArray < Oscal::OscalArray
      MEMBER_TYPE = Attestation
    end

    class ComponentArray < Oscal::OscalArray
      MEMBER_TYPE = Component
    end

    class ControlObjectiveSelectionArray < Oscal::OscalArray
      MEMBER_TYPE = ControlObjectiveSelection
    end

    class ControlSelectionArray < Oscal::OscalArray
      MEMBER_TYPE = ControlSelection
    end

    class EntryArray < Oscal::OscalArray
      MEMBER_TYPE = Entry
    end

    class ExcludeControlArray < Oscal::OscalArray
      MEMBER_TYPE = ExcludeControl
    end

    class ExcludeObjectiveArray < Oscal::OscalArray
      MEMBER_TYPE = ExcludeObjective
    end

    class FindingArray < Oscal::OscalArray
      MEMBER_TYPE = Finding
    end

    class IncludeControlArray < Oscal::OscalArray
      MEMBER_TYPE = IncludeControl
    end

    class InventoryItemArray < Oscal::OscalArray
      MEMBER_TYPE = InventoryItem
    end

    class LinkArray < Oscal::OscalArray
      MEMBER_TYPE = Oscal::Link
    end

    class MethodArray < StringDataTypeArray
    end

    class ObjectivesAndMethodsArray < Oscal::OscalArray
      MEMBER_TYPE = ObjectivesAndMethods
    end

    class ObservationArray < Oscal::OscalArray
      MEMBER_TYPE = Observation
    end

    class PartArray < Oscal::OscalArray
      MEMBER_TYPE = Link
    end

    class PartyUuidArray < UuidArray
    end

    class PropArray < Oscal::OscalArray
      MEMBER_TYPE = Property
    end

    class RelatedObservationArray < Oscal::OscalArray
      MEMBER_TYPE = RelatedObservation
    end

    class RelatedRiskArray < Oscal::OscalArray
      MEMBER_TYPE = AssociatedRisk
    end

    class ResponsibleRoleArray < Oscal::OscalArray
      MEMBER_TYPE = ResponsibleRole
    end

    class ResultArray < Oscal::OscalArray
      MEMBER_TYPE = Result
    end

    class RiskArray < Oscal::OscalArray
      MEMBER_TYPE = Risk
    end

    class StatementIdArray < TokenDataTypeArray
    end

    class StepArray < Oscal::OscalArray
      MEMBER_TYPE = Step
    end

    class SubjectArray < Oscal::OscalArray
      MEMBER_TYPE = Subject
    end

    class TypeArray < TokenDataTypeArray
    end

    class UserArray < Oscal::OscalArray
      MEMBER_TYPE = User
    end
  end
end
