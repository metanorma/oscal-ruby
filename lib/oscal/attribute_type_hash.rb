require_relative("datatypes")

module Oscal
  ATTRIBUTE_TYPE_HASH = {
    href: Oscal::UriReference,
    remarks: Oscal::MarkupMultiline,
  }.freeze

  def get_type_of_attribute(attribute_name)
    Oscal::ATTRIBUTE_TYPE_HASH[attribute_name.to_sym]
  end
end
