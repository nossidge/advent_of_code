#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day14' do
  let(:input1) do
    [
      [9, '5158916779'],
      [5, '0124515891'],
      [18, '9251071085'],
      [2018, '5941429882'],
    ]
  end

  describe '#part1' do
    it do
      input1.each do |value, expected|
        result = Year2018Day14.new.part1(value)
        expect(result).to eq expected
      end
    end
  end

  let(:input2) do
    [
      ['51589', 9],
      ['01245', 5],
      ['92510', 18],
      ['59414', 2018],
    ]
  end

  describe '#part2' do
    it do
      input2.each do |value, expected|
        result = Year2018Day14.new.part2(value)
        expect(result).to eq expected
      end
    end
  end
end
