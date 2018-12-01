#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'

def root
  Pathname(__FILE__).dirname.parent.parent
end

def file2018(filename)
  root + 'data' + '2018' + filename
end
