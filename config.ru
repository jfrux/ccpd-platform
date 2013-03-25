require 'bundler'
Bundler.require
require 'sprockets'
require 'sass'
require 'sprockets-sass'
require './app'

Sinatra::Sprockets.configure do |config|
  config.app = MyApp
  config.host = "http://localhost:9292"
  ['stylesheets', 'javascripts', 'images'].each do |dir|
    config.append_path(File.join('app','assets', dir))
  end
  ['stylesheets', 'javascripts', 'images'].each do |dir|
    config.append_path(File.join('vendor','assets', dir))
  end
  config.compile = true
  config.digest = false
  config.compress = false
  config.debug = true

  #config.precompile = ['application.css','application.js', /.+\.(png|ico|gif|jpeg|jpg)$/]
end
 
map '/assets' do
  run Sinatra::Sprockets.environment
end
 
run MyApp