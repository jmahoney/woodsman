set :stages, %w(production)
set :default_stage, "production"

require 'capistrano/ext/multistage'
require 'bundler/capistrano'
load 'deploy/assets'

set :application, "woodsman"
set :repository,  "git@github.com:jmahoney/woodsman.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :copy_exclude, ['.git', '.ruby_version']
set :copy_cache, true
set :deploy_via, :copy


role :web, "prattle.iterative.co.nz"                          # Your HTTP server, Apache/etc
role :app, "prattle.iterative.co.nz"                          # This may be the same as your `Web` server
role :db,  "prattle.iterative.co.nz", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :user, "joe"
set :use_sudo, false

set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true
#default_run_options[:shell] = '/bin/bash --login'
set :default_environment, {
  "PATH" => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
}

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

before "deploy:assets:precompile",
  "deploy:link:ruby_version", 
  "deploy:link:environment", 
  "deploy:link:uploads",
  "deploy:link:database"       

namespace :deploy do
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{release_path}; bundle install --binstubs"
    #sudo "service nginx restart"
    sudo "service unicorn_woodsman stop"
    sudo "service unicorn_woodsman start"    
    sudo "service memcached stop"
    sudo "service memcached start"
  end
  
  namespace :link do
    task :ruby_version, :except => {:no_release => true}, :roles => :app do
      run "ln -s #{shared_path}/configuration/ruby_version #{release_path}/.ruby-version"
    end

    task :environment, :except => {:no_release => true}, :roles => :app do
      run "ln -s #{shared_path}/configuration/dotenv #{release_path}/.env"
    end
    
    task :uploads, :except => {:no_release => true}, :roles => :app do
      run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
    end
    
    task :database, :except => {:no_release => true}, :roles => :app do
      run "ln -s #{shared_path}/configuration/database.yml #{release_path}/config/database.yml"
    end
  end
end