#!/usr/bin/env ruby
#
# Confidential and proprietary trade secret material of Ribose, Inc.
# (c) 2023 Ribose, Inc. as unpublished work.
#
#
#
# This script attempts to read the ISO 27002:2022 controls and convert to
# OSCAL yaml file.

require "fileutils"
require "optparse"
require "ostruct"
require "yaml"
require "securerandom"
require "asciidoctor"
require "nokogiri"
require "json"
require "time"

def convert_control_to_oscal(control)
  clause_no = control["identifier"].split(":")[-1]

  # set control id
  catalog_control = Catalog::Control.new("clause_#{clause_no}")
  catalog_control.props = []
  catalog_control.parts = []

  control.each do |key, value|
    case key
    when "identifier"
      # add control props
      catalog_control.props << {
        "name" => "clause",
        "value" => clause_no,
      }
    when "maps_27002_2013"
      catalog_control.props << {
        "name" => "maps_27002_2013",
        "value" => value,
      }
    when "title"
      catalog_control.title = value
    when "tags"
      # add tags as props
      value.each do |k, v|
        catalog_control.props << {
          "name" => k,
          "value" => v,
        }
      end
    when "control"
      part          = Catalog::Part.new
      part.id       = "control_#{clause_no}"
      part.name     = "clause_#{clause_no}_control"
      part.prose    = value.chomp
      catalog_control.parts << part.to_hash
    when "purpose"
      part          = Catalog::Part.new
      part.id       = "purpose_#{clause_no}"
      part.name     = "clause_#{clause_no}_purpose"
      part.prose    = value.chomp
      catalog_control.parts << part.to_hash
    when "other_info"
      part          = Catalog::Part.new
      part.id       = "other_info_#{clause_no}"
      part.name     = "clause_#{clause_no}_other_info"
      unless value.empty?
        part.parts = parse_content(
          value,
          clause_no,
          "other_info",
        )
      end
      catalog_control.parts << part.to_hash
    when "guidance"
      # guidance contains multiple parts with title and content
      # each part may contains empty title
      # each part contains content
      # content may contains list or table
      value.each do |v|
        part          = Catalog::Part.new
        part.id       = "scls_#{clause_no.gsub('.', '-')}"
        part.name     = if v["title"].nil?
                          "clause_#{clause_no}_guidance"
                        else
                          v["title"]
                        end
        unless v["content"].empty?
          part.parts = parse_content(
            v["content"],
            clause_no,
          )
        end
        catalog_control.parts << part.to_hash
      end
    end
  end

  catalog_control
end

def add_note(nokogiri_children, _content, part)
  note            = nokogiri_children.css(".note").first.content
  note            = note.gsub("Note", "NOTE:")
  note_part       = Catalog::Part.new
  note_part.id    = "#{part.id}_note"
  note_part.name  = "#{part.name}_note"
  note_part.prose = note

  note_part
end

def replace_link(nokogiri_children, content)
  nokogiri_children.xpath("//a/@href").each do |href|
    href_value = href.value[1..-1]

    clause_no = if href_value.start_with?("scls_")
                  href_value.split("_").last.gsub("-", ".")
                else
                  href_value
                end

    content = content.gsub(
      "[#{href_value}]",
      "[#{clause_no}](##{href_value})",
    )
  end

  content
end

def parse_content(content, clause_no, content_type = "guidance")
  parts = []

  # convert content into html
  html = Asciidoctor.convert content, safe: :safe
  # replace \n with space
  html = html.gsub("\n", " ")
  html = html.gsub("> <", "><")
  # parse html by nokogiri
  htmldoc = Nokogiri::HTML(html)
  # get the body
  body = htmldoc.children[1].children[0]

  prev_part          = nil
  prev_second_part   = nil
  first_level_index  = 0

  body.children.each do |c|
    next if c.content == " "

    tag_name              = c.name
    css_classes           = c.attr("class").split
    is_olist              = css_classes.include?("olist")
    is_table              = tag_name.match?("table")
    contains_alink        = c.search("a").count.positive?
    contains_colon_at_end = c.content.chars.last(1).join == ":"
    is_link_to_table      = contains_alink &&
      c.xpath("//a/@href")[0].value.match?("table")

    if is_olist
      # get all second level list items
      list_items         = c.css("ol[class=arabic] > li")
      second_level_index = 0

      list_items.each do |item|
        part       = Catalog::Part.new
        part.id    = "#{content_type}_#{clause_no}_part_#{first_level_index}_#{second_level_index + 1}"
        part.name  = "#{content_type}_part_list_item"
        content    = item.css("p").first.content

        if item.search("a").count.positive?
          content = replace_link(item, content)
        end

        if item.search(".note").count.positive?
          note_part = add_note(item, content, part)
          part.parts ||= []
          part.parts << note_part
        end

        part.prose        = content
        prev_part.parts ||= []

        # list item contains sublist items
        if item.css("ol").count.positive?
          prev_second_part   = part
          sublist_items      = item.css("li")
          third_level_index  = 0

          sublist_items.each do |sub_item|
            sub_part      = Catalog::Part.new
            sub_part.id   = "#{content_type}_#{clause_no}_part_#{first_level_index}_#{second_level_index + 1}_#{third_level_index + 1}"
            sub_part.name = "#{content_type}_part_list_item"
            content       = sub_item.content

            if sub_item.search("a").count.positive?
              content = replace_link(sub_item, content)
            end

            sub_part.prose = content

            prev_second_part.parts ||= []
            prev_second_part.parts << sub_part

            third_level_index = third_level_index + 1
          end

          part = prev_second_part
        end

        prev_part.parts << part

        second_level_index = second_level_index + 1
      end

      first_level_index = first_level_index - 1
      parts << prev_part
    elsif is_table
      column_num   = 0
      table_header = []
      table_body   = []
      table_prose  = ""

      c.children.each do |item|
        case item.name
        when "caption"
          part       = Catalog::Part.new
          part.id    = "#{content_type}_#{clause_no}_part_#{first_level_index + 1}"
          part.name  = "#{content_type}_table_title"
          part.prose = item.content
          part.props = []
          if item.content.match?(".")
            part.props << {
              "name" => "table",
              "value" => item.content.split(".")[0].split[1],
            }
          end

          parts << part.to_hash
        when "colgroup"
          column_num = item.children.count
        when "thead"
          item.children.children.each do |th|
            # bold header
            head = th.content.empty? ? " " : "*#{th.content}*"
            table_header << head
          end
        when "tbody"
          # loop through tr
          item.children.each do |tr|
            tr_data = []

            # loop through td
            tr.css("td").each do |td|
              tr_data << td.content
            end

            table_body << tr_data
          end
        end
      end

      # create prose for table
      table_prose = "|===\n"
      table_prose << ("|#{table_header.join(' | ')}\n")
      table_body.each do |tr|
        # bold first column
        tr[0] = "*#{tr[0]}*"
        table_prose << ("|#{tr.join(' | ')}\n")
      end
      table_prose << "|==="

      # create part for table
      part       = Catalog::Part.new
      part.id    = "#{content_type}_#{clause_no}_part_#{first_level_index + 1}"
      part.name  = "#{content_type}_table"
      part.prose = table_prose

      parts << part.to_hash
    elsif contains_colon_at_end
      part       = Catalog::Part.new
      part.id    = "#{content_type}_#{clause_no}_part_#{first_level_index + 1}"
      part.name  = "#{content_type}_part"
      content    = c.content

      if contains_alink
        content = replace_link(c, content)
      end

      part.prose = content

      prev_part = part
    else
      part       = Catalog::Part.new
      part.id    = "#{content_type}_#{clause_no}_part_#{first_level_index + 1}"
      part.name  = "#{content_type}_part"
      content    = c.content

      if contains_alink
        content = replace_link(c, content)
      end

      if content.start_with?("Note ")
        content = content.gsub("Note ", "NOTE: ")
      end

      part.prose = content

      parts << part.to_hash
    end

    first_level_index = first_level_index + 1
  end

  parts
end

#
# https://dev.to/ayushn21/how-to-generate-yaml-from-ruby-objects-without-type-annotations-4fli
module Hashify
  # Classes that include this module can exclude certain
  # instance variable from its hash representation by overriding
  # this method
  def ivars_excluded_from_hash
    []
  end

  def to_hash
    hash = {}
    excluded_ivars = ivars_excluded_from_hash

    # Iterate over all the instance variables and store their
    # names and values in a hash
    instance_variables.each do |var|
      next if excluded_ivars.include? var.to_s

      value = instance_variable_get(var)
      value = value.map(&:to_hash) if value.is_a? Array

      hash[var.to_s.delete("@")] = value
    end

    hash
  end
end

#########################################
#
# Catalog
#
# Catalog contains uuid, metadata and groups.
#
class Catalog
  include Hashify

  attr_accessor :catalog

  def initialize(title = nil, remark = nil)
    @catalog                = Hash.new
    @catalog["uuid"]        = SecureRandom.uuid
    @catalog["metadata"]    = Metadata.build(title, remark)
    @catalog["groups"]      = []
    @catalog["back-matter"] = BackMatter.build
  end

  def catalog_groups=(arr)
    @catalog["groups"] = arr
  end

  def add_catalog_groups(arr)
    @catalog["groups"] << arr
  end

  def get_catalog_groups(num)
    @catalog["groups"].select { |g| g.id == num }.first
  end

  def hashify_catalog_groups
    @catalog["groups"].map!(&:to_hash)
  end

  def catalog_groups
    @catalog["groups"]
  end

  #
  # BackMatter
  #
  # BackMatter contains title, published, last-modified, version, oscal-version
  # and remarks
  #
  class BackMatter
    include Hashify

    def self.build
      back_matter_path = File.expand_path(
        "../sources/sections/back-matter.yml",
        __dir__,
      )
      back_matter = YAML.safe_load(File.read(back_matter_path))

      back_matter["resources"].each do |res|
        res["uuid"] = SecureRandom.uuid.to_s
      end

      back_matter
    end
  end

  #
  # Metadata
  #
  # Metadata contains title, published, last-modified, version, oscal-version
  # and remarks
  #
  class Metadata
    include Hashify

    def self.build(title = nil, remark = nil)
      default_title   = "Catalog for ISO27002:2022"
      default_remarks = "OSCAL yaml generated from ISO27002:2022"

      {
        "title" => title.nil? ? default_title : "",
        "published" => Time.now.iso8601,
        "last-modified" => Time.now.iso8601,
        "version" => "1.0",
        "oscal-version" => "1.0.0",
        "remarks" => remark.nil? ? default_remarks : "",
      }
    end
  end

  #
  # Group
  #
  # Group has id and title.
  # Group can contains mulitple controls or groups.
  # Group can contains props in name-value pairs
  #
  class Group
    include Hashify

    attr_accessor :id, :title, :groups, :controls, :props

    def initialize(id, title)
      @id    = id
      @title = title
    end
  end

  #
  # Control
  #
  # Control has id and title.
  # Control can contains mulitple parts.
  # Control can contains props in name-value pairs
  #
  class Control
    include Hashify

    attr_accessor :id, :title, :parts, :props

    def initialize(id)
      @id = id
    end
  end

  #
  # Part
  #
  # Part has id and name
  # Part may contains prose.
  # Part can contains mulitple parts.
  # Part can contains props in name-value pairs
  #
  class Part
    include Hashify

    attr_accessor :id, :name, :prose, :parts, :props
  end
end

def get_group_num_and_name(control_path)
  group_shortname = control_path.split("/")[-2]
  group_num       = control_path.split("/")[-1].split("-")[0]
  groupname       = ""

  case group_shortname
  when "controls-org"
    groupname = "Organizational controls"
  when "controls-people"
    groupname = "People controls"
  when "controls-physical"
    groupname = "Physical controls"
  when "controls-tech"
    groupname = "Technological controls"
  end

  [group_num, groupname]
end

########
# Main #
########
oscal_catalog         = Catalog.new
controls_sections_dir = File.expand_path("../sources/sections", __dir__)
controls_paths_files  = Dir["#{controls_sections_dir}/**/paths.yml"]

# read controls based on paths.yml
controls_paths_files.sort.each do |controls_paths_file|
  controls_paths = YAML.safe_load(File.read(controls_paths_file))
  prev_groupnum  = nil

  controls_paths.each do |control_path|
    groupnum  = get_group_num_and_name(control_path)[0]
    groupname = get_group_num_and_name(control_path)[1]

    if prev_groupnum.nil? || groupnum != prev_groupnum
      # create groups for sections, e.g. 5, 6, 7, 8
      catalog_group = Catalog::Group.new("cls_#{groupnum}", groupname)
      catalog_group.props = [
        {
          "name" => "clause",
          "value" => groupnum,
        },
      ]

      oscal_catalog.add_catalog_groups(catalog_group)
      prev_groupnum = groupnum
    else
      # get existing group
      catalog_group = oscal_catalog.get_catalog_groups("cls_#{groupnum}")
    end

    # DEBUG
    # set control path to a specific yml file path
    # if control_path == "sections/controls-<TYPE>/X-YY.yml"
    # if control_path == "sections/controls-org/5-02.yml"
    control           = YAML.safe_load(File.read("./sources/#{control_path}"))
    converted_control = convert_control_to_oscal(control)

    catalog_group.controls ||= []
    catalog_group.controls << converted_control.to_hash
    # end
  end
end

##########
# Output #
##########

# Remove type annotation from ruby objects
oscal_catalog.hashify_catalog_groups

File.write("scripts/output/iso27002-oscal.yml", oscal_catalog.to_hash.to_yaml)

exit 0
