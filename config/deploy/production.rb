server '104.131.110.110', user: 'deploy', roles: %w{web app db}

set :unicorn_worker_count, 4
set :enable_ssl, false