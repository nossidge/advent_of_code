#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day09' do
  let(:input) do
    [
      [{ players:  9, last_marble:   25 },      32],
      [{ players: 10, last_marble: 1618 },   8_317],
      [{ players: 13, last_marble: 7999 }, 146_373],
      [{ players: 17, last_marble: 1104 },   2_764],
      [{ players: 21, last_marble: 6111 },  54_718],
      [{ players: 30, last_marble: 5807 },  37_305]
    ]
  end

  describe '#part1' do
    it do
      input.each do |value, expected|
        result = Year2018Day09.new.part1(*value.values)
        expect(result).to eq expected
      end
    end
  end

  describe '#part2' do
    it do
      input.each do |value, expected|
        result = Year2018Day09.new.part2(*value.values)
        expect(result).to eq expected
      end
    end
  end
end
