#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day03' do
  let(:input) do
    [
      '#1 @ 1,3: 4x4',
      '#2 @ 3,1: 4x4',
      '#3 @ 5,5: 2x2'
    ]
  end

  describe '#part1' do
    it do
      result = Year2018Day03.new.part1(input)
      expect(result).to eq 4
    end
  end

  describe '#part2' do
    it do
      result = Year2018Day03.new.part2(input)
      expect(result).to eq 3
    end
  end
end
