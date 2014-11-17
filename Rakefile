# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "API Routes"
task :routes do
  ApplicationAPI.routes.each do |api|
    method  =  api.route_method.rjust(23) + "".ljust(3) rescue "".ljust(26)
    path    =  api.route_path
    puts    "     #{method} #{path}"
  end
end