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
end
