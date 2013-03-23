require 'sinatra/base'
require 'sinatra/sprockets'
require 'sass'
require 'sprockets-sass'
 
class MyApp < Sinatra::Base
  helpers Sinatra::Sprockets::Helpers
 
  get '/' do
    'Hello, world!'
  end

  template :stylesheet_tags do
    %q{
    <%= stylesheet_link_tag 'application',:debug => true %>
    }
  end

  template :javascript_tags do
    %q{
    <%= javascript_include_tag 'application',:debug => true %>
    }
  end

  get '/javascript_tags' do
    erb :javascript_tags
  end

   get '/stylesheet_tags' do
    erb :stylesheet_tags
  end
end