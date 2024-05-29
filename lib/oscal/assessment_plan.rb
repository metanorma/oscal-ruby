require_relative "assembly"
require_relative "metadata_block"
require_relative "datatypes"

module Oscal
  module AssessmentPlan
    class ImportSSP < Assembly
      attr_accessor(*(MANDATORY = %i(href).freeze),
                    *(OPTIONAL = %i(remarks).freeze))
    end

    class ReviewedControls < Assembly
      attr_accessor(*(MANDATORY = %i(control_selections).freeze),
                    *(OPTIONAL = %i(description props links
                                    control_objective_selections
                                    remarks).freeze))
    end

    class AssessmentPlan < Assembly
      attr_accessor(*(MANDATORY = %i(uuid metadata import_ssp
                                     reviewed_controls).freeze),
                    *(OPTIONAL = %i(local_definitions terms_and_conditions
                                    reviewed_controls assessment_subjects
                                    assessment_assets tasks
                                    back_matter).freeze))
    end
  end
end
