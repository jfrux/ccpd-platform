Bundler.require
require 'sinatra/base'
require 'sprockets'
require 'sinatra/sprockets-helpers'

class MyApp < Sinatra::Base
  register Sinatra::Sprockets::Helpers
  set :sprockets, Sprockets::Environment.new(root)
  set :assets_prefix, '/assets'
  set :digest_assets, true

  configure do
    #Setup Sprockets
    sprockets.append_path File.join(root, 'assets', 'stylesheets')
    sprockets.append_path File.join(root, 'assets', 'javascripts')
    sprockets.append_path File.join(root, 'assets', 'images')

    configure_sprockets_helpers do |helpers|
      # This will automatically configure Sprockets::Helpers based on the
      # `sprockets`, `public_folder`, `assets_prefix`, and `digest_assets`
      # settings if they exist. Otherwise you can configure as normal:
      helpers.asset_host = 'localhost:8888'
    end
  end

  get '/' do
    erb :index
  end
  template :stylesheet_tags do
    %q{
    <%= stylesheet_tag locals[:file],:expand => true %>
    }
  end

  template :javascript_tags do
    %q{
    <%= javascript_tag locals[:file],:expand => true %>
    }
  end

  get '/javascript_tags' do
    erb :javascript_tags, :locals => {:file => params[:file]}
  end

  get '/stylesheet_tags' do
    erb :stylesheet_tags, :locals => {:file => params[:file]}
  end
end