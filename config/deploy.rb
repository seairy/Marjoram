# -*- encoding : utf-8 -*-
lock '3.3.5'

set :application, 'booking'

set :scm, :git
set :repo_url, 'git@github.com:seairy/Marjoram.git'

set :keep_releases, 3

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system public/uploads}

set :use_sudo, false

namespace :deploy do
  namespace :passenger do
    desc 'Restart passenger server'
    task :restart do
      on roles(:app) do
        within current_path do
          execute :touch, 'tmp/restart.txt'
        end
      end
    end
  end
end

after 'deploy', 'deploy:passenger:restart'