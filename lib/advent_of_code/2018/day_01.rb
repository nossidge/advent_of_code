#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/1
class Year2018Day01
  private def input_txt
    file2018('day_01.txt').readlines.map(&:chomp)
  end

  def part1(input = input_txt)
    input.map(&:to_i).inject(:+)
  end

  def part2(input = input_txt)
    freq = 0
    history = { 0 => 0 }
    input.map(&:to_i).cycle do |i|
      freq += i
      return history[freq] if history[freq]
      history[freq] = freq
    end
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day01.new.part1
  puts Year2018Day01.new.part2
end
