# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe Oscal::AssessmentPlan::AssessmentPlan do
  let(:fields) do
    {
      uuid: "4d56d1ab-d91e-4f7a-9055-1883c4e580b8",
      metadata: {},
      import_ssp: { href: "./ssp.json" },
      reviewed_controls: { control_selections: [] },
    }
  end
  subject { described_class.new(fields) }

  describe "#to_json" do
    it "generates a json representation of the assessment plan" do
      expect(subject.to_json).to be_kind_of(String)
    end
  end
end
