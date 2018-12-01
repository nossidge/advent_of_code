#!/usr/bin/env ruby
# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'advent_of_code'
  s.authors       = ['Paul Thompson']
  s.email         = ['nossidge@gmail.com']

  s.homepage      = 'https://github.com/nossidge/advent_of_code'
  s.summary       = 'Advent of Code - Solutions'
  s.description   = <<~DESC.strip.tr("\n", ' ')
    My solutions for the annual *Advent of Code* programming puzzle challenge.
  DESC

  s.version       = '0.0.1'
  s.date          = '2018-12-01'
  s.license       = 'GPL-3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.3'

  s.add_development_dependency('bundler', '~> 1.13')
  s.add_development_dependency('rake',    '~> 10.0')
  s.add_development_dependency('rspec',   '~> 3.0')
end
