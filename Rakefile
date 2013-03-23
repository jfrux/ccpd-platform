require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
VERSION = "0.0.1"
namespace :railo do
  desc "Start Railo for development"
  task :start do
    system "railo_init"
  end
end

namespace :assets do
  desc "Start Sprockets Server for development"
  task :start do
    system "rackup"
  end
end

desc "Start everything."
multitask :start => [ 'railo:start', 'assets:start' ]


