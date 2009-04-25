require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('nifty-generators', '0.3.1') do |p|
  p.project        = "forked-niftygenerators"
  p.description    = "A collection of useful generator scripts for Rails."
  p.url            = "http://github.com/twilson63/nifty-generators"
  p.author         = 'Tom Wilson, Ryan Bates'
  p.email          = "ryan (at) railscasts (dot) com"
  p.ignore_pattern = ["script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
