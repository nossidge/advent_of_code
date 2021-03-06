#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'date'

Dir[__dir__ + '/advent_of_code/**/*.rb'].each do |file|
  require_relative file
end
