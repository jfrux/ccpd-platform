require 'sprockets'
map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  environment.append_path 'app/assets/images'

  environment.append_path 'vendor/assets/javascripts'
  environment.append_path 'vendor/assets/stylesheets'
  environment.append_path 'vendor/assets/images'
  run environment
end