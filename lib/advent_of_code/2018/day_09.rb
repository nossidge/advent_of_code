#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/9
class Year2018Day09

  # Mutable on the 'array' param
  # Returns the index at which the new value was inserted
  private def insert_at!(array, pos, value)
    pos += 1
    pos = 0 if pos == array.count
    array.insert(pos + 1, value)
    pos + 1
  end

  # Find the index 'movement' elements to the left
  private def index_anti_clockwise(array, pos, movement = 7)
    output = pos - movement
    loop do
      output = array.count + output if output.negative?
      break if output >= 0
    end
    output
  end

  # Naive approach
  def part1(players = 10, last_marble = 25)
    players = (1..players).cycle
    score = Hash.new(0)
    layout = [0]
    pos = 0

    (1..last_marble).each do |value|
      player = players.next

      if (value % 23).zero?
        pos = index_anti_clockwise(layout, pos)
        value_at = layout.delete_at(pos)
        score[player] += value
        score[player] += value_at
        next
      end

      pos = insert_at!(layout, pos, value)
    end
    score.max_by { |_, v| v }.last
  end

  ##############################################################################

  # Let's create a linked list
  class Node
    attr_reader :value
    attr_accessor :cw, :acw
    def initialize(value)
      @value = value
    end
  end

  # Insert between two nodes
  private def insert(a, new_node, b)
    a.cw = new_node
    new_node.acw = a
    new_node.cw = b
    b.acw = new_node
  end

  # Kill a node by re-routing the nodes linked to it
  private def delete(dead_node)
    dead_node.cw.acw = dead_node.acw
    dead_node.acw.cw = dead_node.cw
  end

  # Use the linked list to be much quicker
  def part2(player_count = 10, last_marble = 25)
    players = (0...player_count).cycle
    scores = [0] * player_count

    current = Node.new(0).tap do |node|
      node.cw = node
      node.acw = node
    end

    (1..last_marble).each do |value|
      player = players.next
      if (value % 23).zero?
        dead_node = current.acw.acw.acw.acw.acw.acw.acw
        scores[player] += (value + dead_node.value)
        current = delete(dead_node)
      else
        current = insert(current.cw, Node.new(value), current.cw.cw)
      end
    end

    scores.max
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day09.new.part1(423, 71_944)
  puts Year2018Day09.new.part2(423, 7_194_400)
end
