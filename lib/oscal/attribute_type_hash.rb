require_relative("datatypes")
require_relative("list")

module Oscal
  ATTRIBUTE_TYPE_HASH = {
    activities: AssessmentResult::ActivityArray,
    activity_uuid: Uuid,
    assessment_plan: AssessmentPlan::AssessmentPlan,
    assessment_platforms: AssessmentResult::AssessmentPlatformArray,
    assessment_results: AssessmentResult::AssessmentResult,
    assessment_log: AssessmentResult::AssessmentLog,
    associated_activities: AssessmentResult::AssociatedActivityArray,
    attestations: AssessmentResult::AttestationArray,
    collected: DateTimeWithTimezoneDataType,
    components: AssessmentResult::ComponentArray,
    control_id: TokenDataType,
    control_objective_selections: AssessmentResult::ControlObjectiveSelectionArray,
    control_selections: AssessmentResult::ControlSelectionArray,
    description: MarkupMultilineDataType,
    end: DateTimeWithTimezoneDataType,
    entries: AssessmentResult::EntryArray,
    exclude_controls: AssessmentResult::ExcludeControlArray,
    exclude_objectives: AssessmentResult::ExcludeObjectiveArray,
    expires: DateTimeWithTimezoneDataType,
    findings: AssessmentResult::FindingArray,
    href: UriReference,
    implementation_statement_uuid: Uuid,
    import_ap: AssessmentResult::ImportAP,
    import_ssp: AssessmentPlan::ImportSSP,
    include_all: AssessmentResult::IncludeAll,
    include_controls: AssessmentResult::IncludeControlArray,
    inventory_items: AssessmentResult::InventoryItemArray,
    links: AssessmentResult::LinkArray,
    local_definitions: AssessmentResult::LocalDefinitions,
    metadata: MetadataBlockWrapper,
    methods: AssessmentResult::MethodArray,
    objective_id: TokenDataType,
    objectives_and_methods: AssessmentResult::ObjectivesAndMethodsArray,
    observations: AssessmentResult::ObservationArray,
    observation_uuid: Uuid,
    parts: AssessmentResult::PartArray,
    party_uuids: AssessmentResult::PartyUuidArray,
    props: AssessmentResult::PropArray,
    reason: TokenDataType,
    related_controls: AssessmentResult::RelatedControls,
    related_observations: AssessmentResult::RelatedObservationArray,
    related_risks: AssessmentResult::RelatedRiskArray,
    remarks: MarkupMultilineDataType,
    responsible_roles: AssessmentResult::ResponsibleRoleArray,
    results: AssessmentResult::ResultArray,
    reviewed_controls: AssessmentResult::ReviewedControls,
    risks: AssessmentResult::RiskArray,
    risk_uuid: Uuid,
    role_id: TokenDataType,
    start: DateTimeWithTimezoneDataType,
    state: TokenDataType,
    status: AssessmentResult::Status,
    statement: MarkupMultilineDataType,
    statement_ids: AssessmentResult::StatementIdArray,
    steps: AssessmentResult::StepArray,
    subjects: AssessmentResult::SubjectArray,
    subject_uuid: Uuid,
    target: AssessmentResult::Target,
    target_id: TokenDataType,
    tasks: AssessmentResult::AssessmentTaskArray,
    title: MarkupMultilineDataType,
    type: TokenDataType,
    types: AssessmentResult::TypeArray,
    uuid: Uuid,
    users: AssessmentResult::UserArray,
  }.freeze

  def self.get_type_of_attribute(attribute_name)
    klass = Oscal::ATTRIBUTE_TYPE_HASH[attribute_name.to_sym]
    if klass == nil
      raise InvalidTypeError, "No type found for #{attribute_name}"
    else
      klass
    end
  end
end
