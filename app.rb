Bundler.require
require 'sinatra/base'
require 'sprockets'
require 'sass'
require 'uglifier'
require 'sprockets-sass'
require 'coffee_script'
require 'sprockets-helpers'
require 'sinatra/contrib/all'
require 'sinatra/asset_pipeline'

class MyApp < Sinatra::Base
  # Include these files when precompiling assets
  set :assets_precompile, %w(application.js application.css responsive.css vendors.js *.png *.jpg *.svg *.eot *.ttf *.woff)
  set :asset_host, 'http://localhost:3000' # Use another host for serving assets
  set :assets_protocol, :http # Serve assets using this protocol
  set :assets_css_compressor, :sass # CSS minification
  set :assets_js_compressor, :uglifier # JavaScript minification
  set :static, true
  set :assets_digest, true
  register Sinatra::Contrib
  register Sinatra::AssetPipeline
  configure :production do
    set :assets_prefix, 'assets'
  end

  configure :development do
    set :assets_prefix, '/assets'
  end
  # configure do
  #   #Setup Sprockets
  #   sprockets.append_path File.join(root, 'app', 'assets', 'stylesheets')
  #   sprockets.append_path File.join(root, 'app', 'assets', 'javascripts')
  #   sprockets.append_path File.join(root, 'app', 'assets', 'images')
  #   sprockets.append_path File.join(root, 'vendor', 'assets', 'stylesheets')
  #   sprockets.append_path File.join(root, 'vendor', 'assets', 'javascripts')
  #   sprockets.append_path File.join(root, 'vendor', 'assets', 'images')
  #   sprockets.css_compressor = :sass
  #   sprockets.js_compressor = :uglifier
  #   Sprockets::Helpers.configure do |config|
  #     config.environment = sprockets
  #     config.prefix      = assets_prefix
  #     config.digest      = digest_assets
  #     config.public_path = public_folder
  #     config.manifest    = Sprockets::Manifest.new(sprockets, 'manifset.json')
  #     # Force to debug mode in development mode
  #     # Debug mode automatically sets
  #     # expand = true, digest = false, manifest = false
  #     #config.debug       = true if development?
  #   end
  #end

  template :stylesheet_tags do
    %q{
    <%= stylesheet_tag locals[:file],:expand => false %>
    }
  end

  template :javascript_tags do
    %q{
    <%= javascript_tag locals[:file],:expand => false %>
    }
  end

  helpers do
    include Sprockets::Helpers

    # Alternative method for telling Sprockets::Helpers which
    # Sprockets environment to use.
    # def assets_environment
    #   settings.sprockets
    # end
  end

  before do
    content_type 'text/plain'
  end

  get '/' do
    erb :index
  end

  get '/javascript_tags' do
    renderedHtml = erb :javascript_tags, :locals => {:file => params[:file],:debug => params[:debug]}
    respond_with :index, :name => 'example' do |f|
      f.txt { renderedHtml }
    end
  end

  get '/stylesheet_tags' do
    renderedHtml = erb :stylesheet_tags, :locals => {:file => params[:file],:debug => params[:debug]}
    respond_with :index, :name => 'example' do |f|
      f.txt { renderedHtml }
    end
  end
end