require 'rubygems'
require 'bundler'
Bundler.require
require 'sprite_factory'
#require 'rake'
require "fileutils"
require 'sinatra/asset_pipeline/task.rb'
require './app'

Sinatra::AssetPipeline::Task.define! MyApp

# task :environment do
#   Sinatra::Sprockets.environment = ENV['RACK_ENV']
# end

namespace :railo do
  desc "Start Railo for development"
  task :start do
    system "railo_init"
  end
end

namespace :assets do
  desc "Start Sprockets Server for development"
  task :start do
    system "thin start"
  end


  desc 'recreate sprite images and css'
  task :resprite do 
    SpriteFactory.cssurl = "url('$IMAGE')"    # use a sass-rails helper method to be evaluated by the rails asset pipeline
    SpriteFactory.run!('app/assets/images/icons',
      :width => 16,
      :height => 16,
      :nocomments => true,
      :style => :scss,
      :selector => ".fg-",
      :output_style => 'app/assets/stylesheets/app/sprites.css.scss'
    )
  end
end

namespace :guard do
  desc "Start Guard for development live reload"
  task :start do
    system "guard start -i"
  end
end

desc "Start everything."
multitask :start => [ 'railo:start', 'assets:start' ]


