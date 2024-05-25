require "date"
require_relative "serializer"
require_relative "common_utils"
require_relative "base_class"
require_relative "assembly"
require_relative "metadata_block"

module Oscal
  module AssessmentResult
    class Activity < Assembly
      attr_accessor(*(MANDATORY = %i(uuid).freeze),
                    *(OPTIONAL = %i(title description props links steps
                                    related_controls responsible_roles
                                    remarks).freeze))
    end

    class Attestations < Assembly
      # TODO: Define this. Punting for the time being
    end

    class AssessmentAssets < Assembly
      attr_accessor(*(MANDATORY = %i(assessment_platforms).freeze),
                    *(OPTIONAL = %i(components).freeze))
    end

    class AssessmentLog
      attr_accessor(*(MANDATORY = %i(entries).freeze))
    end

    class AssessmentPlatform < Assembly
      # TODO: Define this. Punting for the time being
    end

    class AssessmentTask < Assembly
      attr_accessor(*(MANDATORY = %i(uuid type title).freeze),
                    *(OPTIONAL = %i(description props links timing dependencies
                                    tasks associated_activities subjects
                                    responsible_roles remarks).freeze))
    end

    class AssociatedActivity < Assembly
      attr_accessor(*(MANDATORY = %i(activity_uuid subjects).freeze),
                    *(OPTIONAL = %i(props links responsible_roles
                                    remarks).freeze))
    end

    class Attestation < Assembly
      # TODO: Define this. Punting for the time being
    end

    class Component < Assembly
      # TODO: Define this. Punting for the time being
    end

    class ControlObjectiveSelection < Assembly
      attr_accessor(*(OPTIONAL = %i(description props links include_all
                                    include_objectives exclude_objectives
                                    remarks).freeze))
    end

    class ControlSelection < Assembly
      attr_accessor(*(OPTIONAL = %i(description props links include_all
                                    include_controls exclude_controls
                                    remarks).freeze))
    end

    class Entry < Assembly
      # TODO: Define this. Punting for the time being
    end

    class ExcludeControl
      # TODO: Define this. Punting for the time being
      # NOTE: This has the same name as profile/exclude-control, but a different
      # definition!
    end

    class ExcludeObjective < Assembly
      attr_accessor(*(MANDATORY = %i(objective_id).freeze))
    end

    class Finding < Assembly
      # TODO: Define this. Punting for the time being
    end

    class ImportAP < Assembly
      attr_accessor(*(MANDATORY = %i(href).freeze),
                    *(OPTIONAL = %i(remarks).freeze))
    end

    class IncludeAll < Assembly
      # This is an Assembly that acts like a flag - it has no no contents
    end

    class IncludeControl < Assembly
      attr_accessor(*(MANDATORY = %i(control_id).freeze),
                    *(OPTIONAL = %i(statement_ids).freeze))
    end

    class IncludeObjective < Assembly
      attr_accessor(*(MANDATORY = %i(objective_id).freeze))
    end

    class InventoryItem < Assembly
      # TODO: Define this. Punting for the time being
    end

    class LocalDefinitions < Assembly
      # NOTE we deviate fromt the spec here! local-definitions is defined twice
      # with different attributes. All attributes are optional, so we merge it
      # into one big back of optional attributes
      attr_accessor(*(OPTIONAL = %i(objectives_and_methods activities
                                    remarks components inventory_items users
                                    assesssment_assets tasks).freeze))
    end

    class ObjectivesAndMethods < Assembly
      attr_accessor(*(MANDATORY = %i(control_id parts).freeze),
                    *(OPTIONAL = %i(description props links remarks).freeze))
    end

    class Observation < Assembly
      attr_accessor(*(MANDATORY = %i(uuid description methods collected).freeze),
                    *(OPTIONAL = %i(title props links methods types origins
                                    subjects relevent_evidence expires
                                    remarks).freeze))
    end

    class RelatedControls < Assembly
      attr_accessor(*(MANDATORY = %i(control_selections).freeze),
                    *(OPTIONAL = %i(description props links
                                    control_objective_selections
                                    remarks).freeze))
    end

    class ResponsibleRole < Assembly
      attr_accessor(*(MANDATORY = %i(role_id).freeze),
                    *(OPTIONAL = %i(props links party_uuids remarks).freeze))
    end

    class Result < Assembly
      attr_accessor(*(MANDATORY = %i(uuid title description start).freeze),
                    *(OPTIONAL = %i(end props links local_definitions
                                    reviewed_controls attestations
                                    assessment_log observations risks findings
                                    remarks).freeze))
    end

    class ReviewedControls < Assembly
      attr_accessor(*(MANDATORY = %i(control_selections).freeze),
                    *(OPTIONAL = %i(description props links
                                    control_objective_selections
                                    remarks).freeze))
    end

    class Risk < Assembly
      # TODO: Define this. Punting for the time being
    end

    class Step < Assembly
      attr_accessor(*(MANDATORY = %i(uuid).freeze),
                    *(OPTIONAL = %i(title description props links
                                    reviewed_controls responsible_roles
                                    remarks).freeze))
    end

    class Subject < Assembly
      attr_accessor(*(MANDATORY = %i(subject_uuid type).freeze),
                    *(OPTIONAL = %i(description props links include_all
                                    include_subjects exclude_subjects
                                    remarks).freeze))
    end

    class Task < Assembly
      # TODO: Define this. Punting for the time being
    end

    class User < Assembly
      # TODO: Define this. Punting for the time being
    end

    ##########################################

    class AssessmentResult < Assembly
      attr_accessor(*(MANDATORY = %i(uuid metadata import_ap results).freeze),
                    *(OPTIONAL = %i(local_definitions back_matter).freeze))
    end
  end
end
