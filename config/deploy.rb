
# config valid only for Capistrano 3.1
lock '3.2.1'

set :stages, ["production"]

set :application, 'angrailmanfullbundle_translation'
set :repo_url, 'git@github.com:rzust/angrailmanfullbundle_translation.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/apps/angrailmanfullbundle_translation'

set :pty, false
set :deploy_via, :remote_cache
set :use_sudo, false
set :conditionally_migrate, false

set :scm, :git
set :ssh_options, {
  port: 24504
}

set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set(:config_files, %w(
  nginx.conf
  database-example.yml
  unicorn.rb
  unicorn_init.sh
))

set(:executable_config_files, %w(
  unicorn_init.sh
))

set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/opt/nginx/sites-enabled/#{fetch(:application)}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:application)}"
  }
])


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
namespace :deploy do

  before 'deploy:setup_config', 'nginx:remove_default_vhost'
  before :deploy, "deploy:check_revision"
  after 'deploy:setup_config', 'nginx:reload'
  after :deploy, "deploy:restart"

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        sudo "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  # desc "restart unicorn server"
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   run "#{current_path}/config/server/#{rails_env}/unicorn_init.sh upgrade"
  # end


  desc "Check if agent forwarding is working"
  task :forwarding do
    on roles(:all) do |h|
      if test("env | grep SSH_AUTH_SOCK")
        info "Agent forwarding is up to #{h}"
      else
        error "Agent forwarding is NOT up to #{h}"
      end
    end
  end

  desc "reload the database with seed data"
  task :seed => [:set_rails_env] do
    on primary (:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end



end

