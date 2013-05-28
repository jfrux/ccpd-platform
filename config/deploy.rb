#replace with your servers information
set :domain, "test.ccpd.uc.edu"
set :user, "ccpdtest"
 
# this name should be the same as the deployment directory on the server
set :application, "test.ccpd.uc.edu"
 
set :scm, :git
set :branch, "develop-v3"
 
# specify a hosted repository
set :repository,  "git@github.com:joshuairl/ccpd-platform.git"
 
# or you can use the path to your local repository
#set :repository,  "file://#{File.expand_path('.')}"
 
server "#{domain}", :app, :web, :db, :primary => true
 
set :deploy_via, :copy
set :copy_exclude, [".git", ".DS_Store"]
 
# set this to the deployment path on your server
set :deploy_to, "/home/#{user}/public_html/#{application}"
 
set :keep_releases, 3
set :git_shallow_clone, 1
 
ssh_options[:paranoid] = false
ssh_options[:forward_agent] = true
set :use_sudo, false
 
# this tells capistrano what to do when you deploy
namespace :deploy do
 
  desc <<-DESC
  A macro-task that updates the code and fixes the symlink.
  DESC
  task :default do
    transaction do
      update_code
      create_symlink
    end
  end
 
  task :update_code, :except => { :no_release => true } do
    on_rollback { run "rm -rf #{release_path}; true" }
    strategy.deploy!
  end
 
  task :after_deploy do
    cleanup
  end
end