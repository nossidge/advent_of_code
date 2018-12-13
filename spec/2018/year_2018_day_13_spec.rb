#!/usr/bin/env ruby
# frozen_string_literal: true

describe 'Year2018Day13' do
  let(:input1) do
    <<~MSG.split("\n")
      |
      v
      |
      |
      |
      ^
      |
    MSG
  end

  let(:input2) do
    <<~'MSG'.split("\n")
      /->-\
      |   |  /----\
      | /-+--+-\  |
      | | |  | v  |
      \-+-/  \-+--/
        \------/
    MSG
  end

  describe '#part1' do
    it do
      result = Year2018Day13.new.part1(input1)
      expect(result).to eq [0, 3]
      result = Year2018Day13.new.part1(input2)
      expect(result).to eq [7, 3]
    end
  end

  let(:input3) do
    <<~'MSG'.split("\n")
      />-<\
      |   |
      | /<+-\
      | | | v
      \>+</ |
        |   ^
        \<->/
    MSG
  end

  describe '#part2' do
    it do
      result = Year2018Day13.new.part2(input3)
      expect(result).to eq [6, 4]
    end
  end
end
