#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day05' do
  let(:input) { 'dabAcCaCBAcCcaDA' }

  describe '#part1' do
    it do
      result = Year2018Day05.new.part1(input)
      expect(result).to eq 10
    end
  end

  describe '#part2' do
    it do
      result = Year2018Day05.new.part2(input)
      expect(result).to eq 4
    end
  end
end
