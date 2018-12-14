#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/14
class Year2018Day14
  private def input_num
    939_601
  end

  class Elf
    attr_reader :index, :score
    def initialize(index, score)
      @index = index
      @score = score
    end

    def next_index(scores)
      @index = (1 + score + index) % scores.count
      @score = scores[@index]
    end
  end

  def make_recipes(elfs)
    num = elfs.inject(0) { |sum, i| sum + i.score }
    num < 10 ? [num] : [1, num % 10]
  end

  def part1(input = input_num)
    scores = [3, 7]
    elves = scores.map.with_index do |score, index|
      Elf.new(index, score)
    end
    recipe_count = scores.count
    loop do
      new_recipes = make_recipes(elves)
      recipe_count += new_recipes.count
      new_recipes.each { |i| scores << i }
      elves.each { |elf| elf.next_index(scores) }
      break if recipe_count >= input + 10
    end
    scores[input, 10].join
  end

  # This takes far too long...
  def part2(input = input_num)
    data = input.to_s.split('').map(&:to_i)
    scores = [3, 7]
    elves = scores.map.with_index do |score, index|
      Elf.new(index, score)
    end
    recipe_count = scores.count
    loop do
      new_recipes = make_recipes(elves)
      recipe_count += new_recipes.count
      new_recipes.each { |i| scores << i }
      elves.each { |elf| elf.next_index(scores) }
      next unless recipe_count > data.length
      ending_scores = scores[-(data.length + 1), 999]
      break if (data == ending_scores[0, 5] || data == ending_scores[1, 5])
    end
    recipe_count - data.length
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day14.new.part1
  puts Year2018Day14.new.part2
end
