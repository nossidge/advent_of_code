#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/2
class Year2018Day02
  private def input_txt
    file2018('day_02.txt').readlines.map(&:chomp)
  end

  private def pos_and_val(array)
    array.map.with_index do |value, index|
      "#{index}#{value}"
    end
  end

  def part1(input = input_txt)
    hashed_lines = input.map(&:chars).map do |i|
      Hash.new { |h, k| h[k] = [] }.tap do |hash|
        i.group_by(&:itself).each do |value, array|
          hash[array.count] << value
        end
      end
    end

    counts = Hash.new(0)
    hashed_lines.each do |hash|
      hash.each_key do |key|
        counts[key] += 1
      end
    end

    counts[2] * counts[3]
  end

  def part2(input = input_txt)
    with_pos = input.map(&:chars).map(&method(:pos_and_val))
    with_pos.combination(2) do |array1, array2|
      intersection = array1 & array2
      if intersection.count + 1 == array1.count
        return intersection.map { |i| i[-1] }.join
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day02.new.part1
  puts Year2018Day02.new.part2
end
