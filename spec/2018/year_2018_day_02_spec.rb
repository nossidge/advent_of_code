#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day02' do
  let(:input1) do
    [
      'abcdef',
      'bababc',
      'abbcde',
      'abcccd',
      'aabcdd',
      'abcdee',
      'ababab'
    ]
  end

  let(:input2) do
    [
      'abcde',
      'fghij',
      'klmno',
      'pqrst',
      'fguij',
      'axcye',
      'wvxyz'
    ]
  end

  describe '#part1' do
    it do
      result = Year2018Day02.new.part1(input1)
      expect(result).to eq 12
    end
  end

  describe '#part2' do
    it do
      result = Year2018Day02.new.part2(input2)
      expect(result).to eq 'fgij'
    end
  end
end
