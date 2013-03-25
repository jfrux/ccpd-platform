require 'rubygems'
require 'bundler'
Bundler.require
require 'sprite_factory'
#require 'rake'
require './app'
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

  desc 'compile assets'
  task :compile => [:compile_js, :compile_css] do
  
  end
 
  desc 'compile javascript assets'
  task :compile_js do
    sprockets = Application.settings.sprockets
    asset     = sprockets['application.js']
    outpath   = File.join(Application.settings.assets_path, 'js')
    outfile   = Pathname.new(outpath).join('application.min.js') # may want to use the digest in the future?
 
    FileUtils.mkdir_p outfile.dirname
 
    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")
    puts "successfully compiled js assets"
  end
 
  desc 'compile css assets'
  task :compile_css do
    sprockets = Application.settings.sprockets
    asset     = sprockets['application.css']
    outpath   = File.join(Application.settings.assets_path, 'css')
    outfile   = Pathname.new(outpath).join('application.min.css') # may want to use the digest in the future?
 
    FileUtils.mkdir_p outfile.dirname
 
    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")
    puts "successfully compiled css assets"
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


