#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/8
class Year2018Day08
  private def input_txt
    file2018('day_08.txt').read.chomp
  end

  class Node
    IDS = (1..Float::INFINITY).lazy.map(&:to_i)
    def self.rewind
      IDS.rewind
    end

    attr_reader :id, :parent
    attr_accessor :children, :children_count
    attr_accessor :metadata, :metadata_count

    def initialize(parent)
      @id = IDS.next
      @parent = parent&.id
      @children = []
      @metadata = []
    end

    def calculate_value(node_hash)
      return metadata.inject(:+) if children.empty?
      metadata_to_child_ids.map do |child_id|
        node_hash[child_id].calculate_value(node_hash)
      end.compact.inject(:+)
    end

    def metadata_to_child_ids
      metadata.map { |i| children[i - 1] }.compact
    end
  end

  ##############################################################################

  def node_hash(input)
    data = input.split.map(&:to_i)
    Node.rewind
    recurse_header(data)
  end

  def recurse_header(data, node_hash = {}, parent = nil)
    return node_hash if data.empty?

    node = Node.new(parent)
    node.children_count = data.shift
    node.metadata_count = data.shift
    node_hash[node.id] = node

    recurse_children(data, node_hash, node, node.children_count)
    recurse_metadata(data, node, node.metadata_count)

    return node_hash unless node.parent
    parent = node_hash[node.parent]
    parent.children << node.id

    node_hash
  end

  def recurse_children(data, node_hash, node, children_count)
    return if children_count.zero?
    recurse_header(data, node_hash, node)
    recurse_children(data, node_hash, node, children_count - 1)
  end

  def recurse_metadata(data, node, metadata_count)
    return if metadata_count.zero?
    metadata_count.times { node.metadata << data.shift }
  end

  ##############################################################################

  def part1(input = input_txt)
    nodes = node_hash(input)
    nodes.values.flat_map(&:metadata).inject(:+)
  end

  def part2(input = input_txt)
    nodes = node_hash(input)
    nodes[1].calculate_value(nodes)
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day08.new.part1
  puts Year2018Day08.new.part2
end
