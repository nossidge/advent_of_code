#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/10
class Year2018Day10
  private def input_txt
    file2018('day_10.txt').readlines.map(&:chomp)
  end

  private def stars_from_input(input)
    input.map do |i|
      nums = i.tr('<>', '  ').split.map(&:to_i)
      position = [nums[1], nums[2]]
      velocity = [nums[4], nums[5]]
      Star.new(Pair.new(position), Pair.new(velocity))
    end
  end

  class Pair
    attr_accessor :x, :y
    def initialize(array)
      @x = array[0]
      @y = array[1]
    end

    def to_a
      [@x, @y]
    end
  end

  class Star
    attr_reader :position, :velocity
    def initialize(position, velocity)
      @position = position
      @velocity = velocity
    end

    def tick
      @position.x += velocity.x
      @position.y += velocity.y
    end

    def untick
      @position.x -= velocity.x
      @position.y -= velocity.y
    end

    def to_a
      @position.to_a
    end
  end

  ##############################################################################

  private def area_info(stars)
    max_x = stars.max_by { |i| i.position.x }.position.x
    max_y = stars.max_by { |i| i.position.y }.position.y
    min_x = stars.min_by { |i| i.position.x }.position.x
    min_y = stars.min_by { |i| i.position.y }.position.y
    {
      max: Pair.new([max_x, max_y]),
      min: Pair.new([min_x, min_y]),
      units: (max_x - min_x) * (max_y - min_y)
    }
  end

  private def make_star_map(stars)
    star_map = {}
    stars.each do |star|
      star_map[star.to_a] = '#'
    end
    (+'').tap do |output|
      area = area_info(stars)
      (area[:min].y..area[:max].y).each do |y|
        (area[:min].x..area[:max].x).each do |x|
          output << (star_map[[x, y]] ? star_map[[x, y]] : '.')
        end
        output << "\n"
      end
    end
  end

  private def star_message(input)
    stars = stars_from_input(input)
    max_units = Float::INFINITY
    (1..Float::INFINITY).each do |seconds|
      stars.each(&:tick)
      area = area_info(stars)
      if max_units < area[:units]
        stars.each(&:untick)
        return {
          message: make_star_map(stars),
          seconds: seconds - 1
        }
      end
      max_units = area[:units]
    end
  end

  def run(input = input_txt)
    result = star_message(input)
    {
      part1: result[:message],
      part2: result[:seconds]
    }
  end
end

if $PROGRAM_NAME == __FILE__
  result = Year2018Day10.new.run
  puts result[:part1]
  puts result[:part2]
end
