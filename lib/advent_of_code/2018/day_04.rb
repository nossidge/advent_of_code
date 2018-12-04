#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/4
class Year2018Day04
  private def input_txt
    file2018('day_04.txt').readlines.map(&:chomp)
  end

  class Guards
    include Enumerable
    attr_reader :guards

    def initialize(input)
      parse_input_data(input)
    end

    # Loop through the values of the 'guards' hash
    def each
      guards.each_value do |guard|
        yield guard
      end
    end

    # Delegate to the 'guards' hash
    def [](id)
      guards[id]
    end

    # Class to model a single guard's sleeping records
    class Guard
      attr_reader :id
      attr_accessor :ranges

      def initialize(id)
        @id = id
        @ranges = []
      end

      def minutes_asleep
        ranges.map(&:to_a).flatten.count
      end

      def asleep_hash
        Hash.new { |h, k| h[k] = [] }.tap do |hash|
          ranges.map(&:to_a).flatten.sort.group_by(&:itself).map do |i, j|
            hash[j.count] << i
          end
        end
      end

      def sleepiest_minute
        asleep_hash[asleep_hash.keys.max].first
      end
    end

    def sleepiest_guard
      max_by(&:minutes_asleep)
    end

    # Parse the input data to create a hash of 'Guard' instances
    def parse_input_data(input)
      @guards = {}
      id = 0
      asleep_minute = nil

      input.sort.each do |line|
        new_guard_id = line[/#\d*/]&.gsub(/\D/, '')&.to_i
        if new_guard_id
          id = new_guard_id
          @guards[id] ||= Guard.new(id)
          next
        end
        date_time = DateTime.parse(line)
        case line.split('] ').last
        when 'falls asleep'
          asleep_minute = date_time.minute
        when 'wakes up'
          range = (asleep_minute...date_time.minute)
          @guards[id].ranges << range
        end
      end
    end
  end

  ##############################################################################

  def part1(input = input_txt)
    sleepiest_guard = Guards.new(input).sleepiest_guard
    sleepiest_guard.id * sleepiest_guard.sleepiest_minute
  end

  def part2(input = input_txt)
    sleepiest_minute_count = 0
    sleepiest_minute_id = 0

    guards = Guards.new(input)
    guards.each do |guard|
      max = guard.asleep_hash.keys.max
      if max && sleepiest_minute_count < max
        sleepiest_minute_count = max
        sleepiest_minute_id = guard.id
      end
    end

    id = sleepiest_minute_id
    id * guards[id].sleepiest_minute
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day04.new.part1
  puts Year2018Day04.new.part2
end
