require 'sinatra/base'
require 'sprockets'
require 'sinatra-sprockets'
require 'less' 
require 'sprockets-less'

Sinatra::Sprockets.configure do |config|
  config.app = Sprocketeer

  ['stylesheets', 'javascripts', 'images'].each do |dir|
    config.append_path(File.join('app', 'assets', dir))
  end
end

class Sprocketeer < Sinatra::Base
  set :sprockets, Sprockets::Environment.new(root)
  set :assets_prefix, '/assets'
  set :digest_assets, false

  helpers Sinatra::Sprockets::Helpers

  
  map '/assets' do
    run Sinatra::Sprockets.environment
  end

  template :stylesheet_tags do
    %q{
    <%= stylesheet_tag 'application',:expand => true %>
    }
  end
  get '/stylesheet_tags' do
    erb :stylesheet_tags
  end

end