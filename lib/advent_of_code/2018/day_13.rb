#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# https://adventofcode.com/2018/day/13
class Year2018Day13
  private def input_txt
    file2018('day_13.txt').readlines.map(&:chomp)
  end

  class Cart
    include Comparable

    DIRECTION_TURN = {
      '^' => {
        left: '<',
        straight: '^',
        right: '>'
      },
      'v' => {
        left: '>',
        straight: 'v',
        right: '<'
      },
      '<' => {
        left: 'v',
        straight: '<',
        right: '^'
      },
      '>' => {
        left: '^',
        straight: '>',
        right: 'v'
      }
    }.freeze
    FORWARD_SLASH = {
      '>' => '^',
      '<' => 'v',
      '^' => '>',
      'v' => '<'
    }.freeze
    BACK_SLASH = {
      '>' => 'v',
      '<' => '^',
      '^' => '<',
      'v' => '>'
    }.freeze

    attr_reader :x, :y, :direction
    attr_accessor :dead
    def initialize(x, y, direction)
      @x = x
      @y = y
      @direction = direction
      @turn = %i[left straight right].cycle
      @dead = false
    end

    def rail_underneath
      %w[< >].include?(direction) ? '-' : '|'
    end

    def to_a
      [x, y] unless dead
    end

    def <=>(other)
      [y, x] <=> [other.y, other.x]
    end

    def tick(rails)
      return if dead
      update_coords
      case rails[to_a]
      when '/'
        @direction = FORWARD_SLASH[direction]
      when '\\'
        @direction = BACK_SLASH[direction]
      when '+'
        @direction = DIRECTION_TURN[direction][@turn.next]
      end
    end

    def update_coords
      case direction
      when '>'
        @x += 1
      when '<'
        @x -= 1
      when '^'
        @y -= 1
      when 'v'
        @y += 1
      end
    end
  end

  # Determine the initial state of the tracks
  private def rails_carts_from_input(input)
    [{}, []].tap do |output|
      input.each.with_index do |row, y|
        row.chars.each.with_index do |char, x|
          if %w[^ v < >].include?(char)
            cart = Cart.new(x, y, char)
            char = cart.rail_underneath
            output[1] << cart
          end
          output[0][[x, y]] = char if char != ' '
        end
      end
    end
  end

  def part1(input = input_txt)
    rails, carts = rails_carts_from_input(input)
    loop do
      carts.sort.each do |cart|
        all_cart_coords = carts.map(&:to_a)
        cart.tick(rails)
        return cart.to_a if all_cart_coords.include?(cart.to_a)
      end
    end
  end

  def part2(input = input_txt)
    rails, carts = rails_carts_from_input(input)
    loop do
      carts.sort.each do |cart|
        next if cart.dead
        all_cart_coords = carts.map(&:to_a).compact
        cart.tick(rails)
        return cart.to_a if all_cart_coords.count <= 1
        next unless all_cart_coords.include?(cart.to_a)
        other_carts = carts.select { |i| i.to_a == cart.to_a }
        other_carts.each { |i| i.dead = true }
        cart.dead = true
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  p Year2018Day13.new.part1
  p Year2018Day13.new.part2
end
