require 'sinatra/base'
require 'sinatra/sprockets'
require 'sinatra/sprockets/asset_paths'
require 'sass'
require 'coffee_script'
require 'sprockets-sass'
 
class MyApp < Sinatra::Base
  helpers Sinatra::Sprockets::Helpers

  template :stylesheet_tags do
    %q{
    <%= stylesheet_link_tag locals[:file],:debug => true %>
    }
  end

  template :javascript_tags do
    %q{
    <%= javascript_include_tag locals[:file],:debug => true %>
    }
  end

  get '/javascript_tags' do
    erb :javascript_tags, :locals => {:file => params[:file]}
  end

   get '/stylesheet_tags' do
    erb :stylesheet_tags, :locals => {:file => params[:file]}
  end
end