#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/3
class Year2018Day03
  private def input_txt
    file2018('day_03.txt').readlines.map(&:chomp)
  end

  class Claim
    attr_reader :id, :product
    def initialize(input)
      @id  = input[/#\d*/]  .gsub(/\D/, '').to_i
      left = input[/ @ \d*/].gsub(/\D/, '').to_i
      top  = input[/,\d*/]  .gsub(/\D/, '').to_i
      wide = input[/: \d*/] .gsub(/\D/, '').to_i
      tall = input[/x\d*/]  .gsub(/\D/, '').to_i
      x_values = (left...(left + wide)).to_a
      y_values = (top...(top + tall)).to_a
      @product = x_values.product(y_values).map { |x, y| "#{x},#{y}" }
    end
  end

  private def area(input = input_txt)
    area = Hash.new { |h, k| h[k] = [] }
    claims = input.map { |i| Claim.new(i) }
    claims.each do |claim|
      claim.product.each do |coord|
        area[coord] << claim.id
      end
    end
    area = area.group_by { |_, v| v.count }
  end

  def part1(input = input_txt)
    area = area(input)
    area.to_hash.keys.sort[1..-1].map do |k|
      area[k].count
    end.inject(:+)
  end

  def part2(input = input_txt)
    claims = input.map { |i| Claim.new(i) }
    hash_area = area(input).to_hash
    overlaps = hash_area.keys.sort[1..-1].map do |k|
      hash_area[k].map { |_, ids| ids }.flatten.uniq.sort
    end.flatten.uniq.sort
    id = (1..claims.map(&:id).max).to_a - overlaps
    raise StandardError if id.count > 1
    id.first
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day03.new.part1
  puts Year2018Day03.new.part2
end
