# frozen_string_literal: true

RSpec.describe Oscal::Catalog do
  let(:subject) do
    Oscal::Catalog.load_from_yaml(
      "spec/oscal-content/examples/catalog/yaml/basic-catalog.yaml",
    )
  end

  it "parses oscal-content YAML" do
    expect(subject.class).to be Oscal::Catalog
    expect(subject.groups.first.groups.first.parts.first.prose).to eq(
      "To establish a management framework to initiate and " \
      "control the implementation and operation of information security " \
      "within the organization.",
    )
  end

  it "gets all controls" do
    expect(subject.class).to be Oscal::Catalog
    expect(subject.get_all_controls.count).to eq(4)
  end

  it "find object by id" do
    obj = subject.find_object_by_id('s2.1_smt')
    expect(obj.to_s).to match(/Oscal::Part/)
    expect(obj.prose).to eq(
      "To limit access to information and information processing facilities.")
  end

  it "find object by uuid" do
    uuid = '74c8ba1e-5cd4-4ad1-bbfd-d888e2f6c724'
    obj = subject.find_object_by_id(
      uuid, subject, :uuid
    )
    expect(obj.to_s).to match(/Oscal::Catalog/)
    expect(obj.uuid).to eq(uuid)
  end
end
