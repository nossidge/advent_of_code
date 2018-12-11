#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day11' do
  let(:input_power_level) do
    [
      [[57, 122,  79], -5],
      [[39, 217, 196],  0],
      [[71, 101, 153],  4]
    ]
  end

  let(:input1) do
    [
      [[18, 65, 3], '33,45,3'],
      [[42, 65, 3], '21,61,3']
    ]
  end

  let(:input2) do
    [
      [[1312, 40], '34,28,4'],
      [[3145, 10], '4,8,3'],
      [[  12, 10], '4,6,4'],
    ]
  end

  describe '#power_level' do
    it do
      input_power_level.each do |args, expected|
        result = Year2018Day11.new.power_level(*args)
        expect(result).to eq expected
      end
    end
  end

  describe '#part1' do
    it do
      input1.each do |args, expected|
        result = Year2018Day11.new.part1(*args)
        expect(result).to eq expected
      end
    end
  end

  describe '#part2' do
    it do
      input2.each do |args, expected|
        result = Year2018Day11.new.part2(*args)
        expect(result).to eq expected
      end
    end
  end
end
