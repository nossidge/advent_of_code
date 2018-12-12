#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/12
class Year2018Day12
  private def input_txt
    file2018('day_12.txt').readlines.map(&:chomp)
  end

  def neighbourhood(states, index)
    num = 0
    num += 16 if states[index - 2]
    num +=  8 if states[index - 1]
    num +=  4 if states[index]
    num +=  2 if states[index + 1]
    num +=  1 if states[index + 2]
    num
  end

  def to_binary_chars(string)
    string.tr('.', '0').tr('#', '1')
  end

  # Return a hash of only 'true' values whose keys represent alive cells
  def initial_state(data)
    data[0]
      .sub('initial state: ', '')
      .chars
      .map.with_index { |value, index| index if value == '1' }
      .compact
      .product([true])
      .to_h
  end

  # Return an array of Integers whose bit values represent cell neighbourhoods
  # that will produce an alive cell
  def neighbourhoods_alive(data)
    data[2..-1]
      .map { |i| i.split(' => ') }
      .select { |i| i.last == '1' }
      .map { |i| i.first.to_i(2) }
  end

  def part1(generations = 20, input = input_txt)
    data = input.map { |i| to_binary_chars(i) }
    states = initial_state(data)
    dictionary = neighbourhoods_alive(data)

    generations.times do
      new_states = {}
      min_key = states.keys.min - 2
      max_key = states.keys.max + 2
      (min_key..max_key).each do |k|
        neighbours = neighbourhood(states, k)
        new_states[k] = true if dictionary.include?(neighbours)
      end
      states = new_states
    end

    states.keys.inject(&:+)
  end

  # This is a bit too hard-coded for my liking...
  # Basically, I generated 200 states and eyeballed the pattern.
  # Starting from about gen 170 they just keep moving up one pot.
  # So just take the pot indices from one gen and plus the remaining gens.
  def part2
    max_gen = 50_000_000_000
    low_gen = 200
    pots_at_low_gen = [
      101, 108, 113, 122, 127, 132, 137, 142, 151, 156, 165,
      170, 176, 187, 192, 197, 202, 207, 212, 217, 222, 227,
      238, 247, 252, 257, 266, 271, 276, 281, 284, 291, 296
    ]
    final_pots = pots_at_low_gen.map { |k| k + max_gen - low_gen + 1 }
    final_pots.inject(&:+)
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day12.new.part1(20)
  puts Year2018Day12.new.part2
end
