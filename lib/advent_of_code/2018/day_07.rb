#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/7
class Year2018Day07
  private def input_txt
    file2018('day_07.txt').readlines.map(&:chomp)
  end

  class Step
    attr_reader :id
    attr_accessor :depends_on, :dependants
    def initialize(id)
      @id = id
      @depends_on = []
      @dependants = []
    end
  end

  # Make a hash of Step instances
  def steps_hash(input)
    Hash.new { |h, k| h[k] = Step.new(k) }.tap do |hash|
      input.map(&:split).each do |_, before, _, _, _, _, _, after|
        hash[before].dependants << after
        hash[after].depends_on << before
      end
    end
  end

  # Find the initial elements with no dependencies
  def find_open_steps(steps)
    steps.flat_map do |_, step|
      step.id if step.depends_on.empty?
    end.compact.sort
  end

  def part1(input = input_txt)
    steps = steps_hash(input)
    open_steps = find_open_steps(steps)

    # Keep finding the elements with no dependencies
    steps_in_order = []
    loop do
      open_steps.sort!
      current_step = open_steps.shift
      break unless current_step
      steps_in_order << current_step
      steps_in_order.uniq!
      deps = steps[current_step].dependants
      deps -= steps_in_order
      deps = deps.map do |i|
        outstanding = steps[i].depends_on - steps_in_order
        i if outstanding.empty?
      end.compact
      open_steps += deps
      open_steps.uniq
    end
    steps_in_order.join
  end

  ##############################################################################

  class Worker
    attr_reader :id, :step_duration, :task, :seconds_remaining

    def initialize(id, step_duration = 0)
      @id = id
      @seconds_remaining = 0
      @step_duration = step_duration
    end

    def task=(task)
      @task = task
      @seconds_remaining = task.ord - 64 + step_duration
    end

    def tick
      @seconds_remaining -= 1
    end

    def free?
      seconds_remaining <= 0
    end
  end

  def part2(worker_count = 2, step_duration = 0, input = input_txt)
    steps = steps_hash(input)
    open_steps = find_open_steps(steps)
    workers = Array.new(worker_count) { |i| Worker.new(i, step_duration) }
    assigned_tasks = []
    seconds = 0

    loop do
      workers.each(&:tick)

      workers.each do |worker|
        next unless worker.free?
        just_completed = worker.task
        next unless just_completed
        steps.each_value { |step| step.depends_on.delete(just_completed) }
        steps.delete(just_completed)
        open_steps = find_open_steps(steps) - assigned_tasks
      end

      workers.each do |worker|
        next unless worker.free?
        new_task = open_steps.shift
        break unless new_task
        worker.task = new_task
        assigned_tasks << new_task
      end

      break if workers.map(&:free?).inject(:&)
      seconds += 1
    end

    seconds
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year2018Day07.new.part1
  puts Year2018Day07.new.part2(5, 60)
end
