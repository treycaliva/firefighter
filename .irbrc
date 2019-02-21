$:.unshift File.expand_path('lib')

require 'firefighter'
require_relative 'spec/support/credentials'

@client = Firefighter::RealtimeDatabase.from_env
