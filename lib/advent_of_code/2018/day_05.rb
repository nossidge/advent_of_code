#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/5
class Year2018Day05
  private def input_txt
    file2018('day_05.txt').read.chomp
  end

  private def reactions
    @reactions ||= ('a'..'z').flat_map do |letter|
      [letter, letter.upcase].permutation.to_a
    end.map(&:join)
  end

  private def delete_reactions!(data)
    data.tap do |output|
      reactions.each do |i|
        output.gsub!(i, '')
      end
    end
  end

  private def react_polymer(input)
    input.dup.tap do |data|
      loop do
        data_orig = data.dup
        delete_reactions!(data)
        break if data_orig == data
      end
    end
  end

  def part1(input = input_txt)
    react_polymer(input).size
  end

  def part2(input = input_txt)
    ('a'..'z').map do |letter|
      data = input.gsub(/#{letter}/i, '')
      react_polymer(data).size
    end.min
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day05.new.part1
  puts Year2018Day05.new.part2
end
