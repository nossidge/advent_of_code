#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/6
class Year2018Day06
  private def input_txt
    file2018('day_06.txt').readlines.map(&:chomp)
  end

  private def input_to_points(input)
    array = input.map { |i| i.split(', ').map(&:to_i) }
    array.map { |x, y| Point.new(x, y) }
  end

  class Point
    attr_reader :id, :x, :y

    def initialize(x, y)
      @id = "#{x},#{y}"
      @x = x
      @y = y
    end

    def manhattan(point_or_x_val, y_val = nil)
      if y_val
        x_val = point_or_x_val
      else
        x_val = point_or_x_val.x
        y_val = point_or_x_val.y
      end
      (x_val - x).abs + (y_val - y).abs
    end
  end

  ##############################################################################

  def part1(input = input_txt)
    points = input_to_points(input)

    x_max = points.max_by(&:x).x + 1
    y_max = points.max_by(&:y).y + 1

    area = Hash.new { |h, k| h[k] = [] }

    points.each do |point|
      0.upto(x_max) do |x|
        0.upto(y_max) do |y|
          area[[x, y]] << [point.manhattan(x, y), point]
        end
      end
    end

    # Get rid of all but the nearest points
    # Remove any that contain multiples
    area.each do |_, values|
      min_dist = values.min_by(&:first).first
      min_points = values.select { |i| i.first == min_dist }
      new_values = min_points.size == 1 ? min_points.first : []
      values.replace(new_values)
    end

    # Find the coords at the edges
    edges = [0, x_max].flat_map do |x|
      (0..y_max).map { |y| [x, y] }
    end + (0..x_max).flat_map do |x|
      [0, y_max].map { |y| [x, y] }
    end

    # Find the points at the edges
    ids = edges.map do |i|
      area[i].last&.id
    end.compact.uniq

    # Remove those infinite ids
    area.each do |_, values|
      next if values.empty?
      next unless ids.include?(values[1].id)
      values.replace([])
    end
    remove_inf = area.map do |_, values|
      next if values.empty?
      values[1].id
    end.compact

    # Count the remaining ids
    count_hash = remove_inf.each_with_object(Hash.new(0)) do |id, hash|
      hash[id] += 1
    end
    count_hash.max_by { |_, v| v }.last
  end

  def part2(distance_too_high, input = input_txt)
    points = input_to_points(input)

    x_max = points.max_by(&:x).x + 1
    y_max = points.max_by(&:y).y + 1

    area = {}

    0.upto(x_max) do |x|
      0.upto(y_max) do |y|
        total_distance = 0
        points.each do |point|
          total_distance += point.manhattan(x, y)
          if total_distance >= distance_too_high
            total_distance = nil
            break
          end
        end
        area[[x, y]] = total_distance if total_distance
      end
    end

    area.count
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day06.new.part1
  puts Year2018Day06.new.part2(10_000)
end
