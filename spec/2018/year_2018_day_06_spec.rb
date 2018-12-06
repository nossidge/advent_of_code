#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day06' do
  let(:input) do
    [
      '1, 1',
      '1, 6',
      '8, 3',
      '3, 4',
      '5, 5',
      '8, 9'
    ]
  end

  describe '#part1' do
    it do
      result = Year2018Day06.new.part1(input)
      expect(result).to eq 17
    end
  end

  describe '#part2' do
    it do
      result = Year2018Day06.new.part2(32, input)
      expect(result).to eq 16
    end
  end
end
