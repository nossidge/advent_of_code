#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/11
class Year2018Day11
  def power_level(gsn, x, y)
    rack_id = x + 10
    output = rack_id * y
    output += gsn
    output *= rack_id
    output.to_s[-3].to_i - 5
  end

  # https://en.wikipedia.org/wiki/Summed-area_table
  def integral_value(cell_value, integral, x, y)
    cell_value + integral[[x - 1, y]] +
      integral[[x, y - 1]] - integral[[x - 1, y - 1]]
  end

  def area_sum(integral, x1, y1, x2, y2)
    if x1 == 1 && y1 == 1
      integral[[x2, y2]]
    else
      integral[[x2, y2]] -
        integral[[x1 - 1, y2]] -
        integral[[x2, y1 - 1]] +
        integral[[x1 - 1, y1 - 1]]
    end
  end

  def square_sum(integral, x, y, length)
    x2 = x + length - 1
    y2 = y + length - 1
    area_sum(integral, x, y, x2, y2)
  end

  def create_integral_cells(gsn, size)
    Hash.new(0).tap do |hash|
      (1..size).each do |x|
        (1..size).each do |y|
          cell_value = power_level(gsn, x, y)
          hash[[x, y]] = integral_value(cell_value, hash, x, y)
        end
      end
    end
  end

  def run(gsn, size, square_len = nil)
    integral = create_integral_cells(gsn, size)
    max_id = nil
    max_sum = -Float::INFINITY
    (1..size).each do |x|
      (1..size).each do |y|
        max_square_size = size - [x, y].max + 1
        (1..max_square_size).each do |len|
          next unless square_len.nil? || square_len == len
          sum = square_sum(integral, x, y, len)
          if sum > max_sum
            max_sum = sum
            max_id = "#{x},#{y},#{len}"
          end
        end
      end
    end
    max_id
  end

  # 'gsn' is the grid serial number
  def part1(gsn = 7315, size = 300, square_len = 3)
    run(gsn, size, square_len)
  end

  def part2(gsn = 7315, size = 300, square_len = nil)
    run(gsn, size, square_len)
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day11.new.part1
  puts Year2018Day11.new.part2
end
