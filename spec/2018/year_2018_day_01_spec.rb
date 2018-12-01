#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day01' do
  let(:input1) do
    [
      ['+1, -2, +3, +1', 3],
      ['+1, +1, +1', 3],
      ['+1, +1, -2', 0],
      ['-1, -2, -3', -6]
    ]
  end

  let(:input2) do
    [
      ['+1, -2, +3, +1', 2],
      ['+1, -1', 0],
      ['+3, +3, +4, -2, -4', 10],
      ['-6, +3, +8, +5, -6', 5],
      ['+7, +7, -2, -7, -4', 14]
    ]
  end

  describe '#part1' do
    it do
      input1.each do |value, expected|
        result = Year2018Day01.new.part1(value.split)
        expect(result).to eq expected
      end
    end
  end

  describe '#part2' do
    it do
      input2.each do |value, expected|
        result = Year2018Day01.new.part2(value.split)
        expect(result).to eq expected
      end
    end
  end
end
