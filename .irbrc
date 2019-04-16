$:.unshift File.expand_path('lib')

require 'byebug'
require 'firefighter'
require_relative 'spec/support/credentials'

@client = Firefighter::RealtimeDatabase.from_env
puts "loaded realtime db, use the @client var"
