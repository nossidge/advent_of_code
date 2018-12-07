#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day07' do
  let(:input) do
    [
      'Step C must be finished before step A can begin.',
      'Step C must be finished before step F can begin.',
      'Step A must be finished before step B can begin.',
      'Step A must be finished before step D can begin.',
      'Step B must be finished before step E can begin.',
      'Step D must be finished before step E can begin.',
      'Step F must be finished before step E can begin.'
    ]
  end

  describe '#part1' do
    it do
      result = Year2018Day07.new.part1(input)
      expect(result).to eq 'CABDFE'
    end
  end

  describe '#part2' do
    it do
      result = Year2018Day07.new.part2(2, 0, input)
      expect(result).to eq 15
    end
  end
end
