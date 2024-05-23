module Oscal
  module Array
    def input_is_array?(input)
      unless input.is_a? Array
        raise InvalidTypeError,
              "#{self.class} can only be composed by Arrays"
      end
    end

    def validate_member_type(input)
      input.each do |item|
        self.class::MEMBER_TYPE.new(item)
      end
    end

    def initialize(input)
      input_is_array?(input)
      validate_member_type(input)
    end
  end

  class ActivityArray
    include Array
    MEMBER_TYPE = Activity
  end

  class AssessmentPlatformArray
    include Array
    MEMBER_TYPE = AssessmentPlatform
  end

  class AssessmentTaskArray
    include Array
    MEMBER_TYPE = AssessmentTask
  end

  class AttestationArray
    include Array
    MEMBER_TYPE = Attestation
  end

  class ComponentArray
    include Array
    MEMBER_TYPE = Component
  end

  class ControlObjectiveSelectionArray
    include Array
    MEMBER_TYPE = ControlObjectiveSelection
  end

  class EntryArray
    include Array
    MEMBER_TYPE = Entry
  end

  class ExcludeControlArray
    include Array
    MEMBER_TYPE = ExcludeControl
  end

  class ExcludeObjectiveArray
    include Array
    MEMBER_TYPE = ExcludeObjective
  end

  class FindingArray
    include Array
    MEMBER_TYPE = Finding
  end

  class IncludeControlArray
    include Array
    MEMBER_TYPE = IncludeControl
  end

  class InventoryItemArray
    include Array
    MEMBER_TYPE = InventoryItem
  end

  class LinkArray
    include Array
    MEMBER_TYPE = Link
  end

  class ObjectivesAndMethodsArray
    include Array
    MEMBER_TYPE = ObjectivesAndMethods
  end

  class ObservationArray
    include Array
    MEMBER_TYPE = Observation
  end

  class PartArray
    include Array
    MEMBER_TYPE = Link
  end

  class PartyUuidArray
    include Array
    MEMBER_TYPE = Uuid
  end

  class PropArray
    include Array
    MEMBER_TYPE = Property
  end

  class ResponsibleRoleArray
    include Array
    MEMBER_TYPE = ResponsibleRole
  end

  class RiskArray
    include Array
    MEMBER_TYPE = Risk
  end

  class StepArray
    include Array
    MEMBER_TYPE = Step
  end

  class UserArray
    include Array
    MEMBER_TYPE = User
  end
end
