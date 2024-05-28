require "date"
require_relative "serializer"
require_relative "common_utils"
require_relative "base_class"
require_relative "assembly"
require_relative "metadata_block"
require_relative "datatypes"

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

    class AssociatedRisk < Assembly
      attr_accessor(*(MANDATORY = %i(risk_uuid).freeze))
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
      attr_accessor(*(MANDATORY = %i(uuid title description target).freeze),
                    *(OPTIONAL = %i(implementation_statement_uuid
                                    related_observations related_risks
                                    remarks).freeze))
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

    class RelatedObservation < Assembly
      attr_accessor(*(MANDATORY = %i(observation_uuid).freeze),
                    *(OPTIONAL = %i().freeze))
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
      attr_accessor(*(MANDATORY = %i(uuid title description statement
                                     status).freeze),
                    *(OPTIONAL = %i(propse links origins threat_ids
                                    characterizations mitigating_factors
                                    deadline remediations risk_log
                                    related_observations).freeze))
    end

    class Status
      # Status is defined twice, once as a datatype, once as an assembly
      # this class figures out which is which
      def initialize(input)
        if input.instance_of? String
          StatusString.new(input)
        elsif input.instance_of? Hash
          StatusAssembly.new(input)
        else
          raise Oscal::InvalidTypeError, "status must be a string or assembly"
        end
      end
    end

    class StatusString < TokenDataType
    end

    class StatusAssembly < Assembly
      attr_accessor(*(MANDATORY = %i(state).freeze),
                    *(OPTIONAL = %i(reason remarks).freeze))
    end

    class Step < Assembly
      attr_accessor(*(MANDATORY = %i(uuid).freeze),
                    *(OPTIONAL = %i(title description props links
                                    reviewed_controls responsible_roles
                                    remarks).freeze))
    end

    class Subject < Assembly
      attr_accessor(*(OPTIONAL = %i(subject_uuid type
                                    description props links include_all
                                    include_subjects exclude_subjects
                                    remarks).freeze))
    end

    class Target < Assembly
      attr_accessor(*(MANDATORY = %i(type target_id status).freeze),
                    *(OPTIONAL = %i(title description props links
                                    implementation_status remarks).freeze))
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
