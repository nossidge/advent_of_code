#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day12' do
  let(:input) do
    <<~MSG.split("\n")
      initial state: #..#.#..##......###...###

      ...## => #
      ..#.. => #
      .#... => #
      .#.#. => #
      .#.## => #
      .##.. => #
      .#### => #
      #.#.# => #
      #.### => #
      ##.#. => #
      ##.## => #
      ###.. => #
      ###.# => #
      ####. => #
    MSG
  end

  describe '#part1' do
    it do
      result = Year2018Day12.new.part1(20, input)
      expect(result).to eq 325
    end
  end
end
