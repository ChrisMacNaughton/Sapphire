task :console do
  require 'irb'
  require 'bundler/setup'
  require 'llvm/core'
  require_relative 'lib/sapphire'
  include Sapphire
  ARGV.clear
  IRB.start
end