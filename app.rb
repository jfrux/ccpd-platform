require 'sinatra/base'
require 'sinatra/sprockets'
require 'sprockets-less'
 
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

  get '/stylesheet_tags' do
    erb :stylesheet_tags
  end
end