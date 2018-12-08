#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day08' do
  let(:input) { '2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2' }

  describe '#part1' do
    it do
      result = Year2018Day08.new.part1(input)
      expect(result).to eq 138
    end
  end

  describe '#part2' do
    it do
      result = Year2018Day08.new.part2(input)
      expect(result).to eq 66
    end
  end
end
