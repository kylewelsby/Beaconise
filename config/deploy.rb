set :user, "beaconise"
set :domain, "beaconise.com"
set :application, "beaconise"
set :applicationdir, "/home/#{user}/#{domain}"
ssh_options[:keys] = %w(/Users/kyle/.ssh/id_dsa)

set :scm_username, "kyle@beaconise.com"
set :scm_password, "ov54xou"
set :repository,  "http://svn.mekyle.com/beaconise/"


role :app, domain
role :web, domain
role :db,  domain, :primary => true


set :deploy_to, applicationdir
set :deploy_via, :export

default_run_options[:pty] = true
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :chmod777, "script/spin"
set :use_sudo, false

desc "Link shared files"
task :before_symlink do
  run "rm -drf #{release_path}/public/uploads"
  run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
end

# namespace :deploy do
#  desc "Create asset packages for production" 
#  task :after_update_code, :roles => [:web, :app] do
#    run <<-EOF
#      cd #{release_path} && rake asset:packager:build_all
#    EOF
#  end
# end

namespace :deploy do 
  task :vendor_rails, :roles => :app do  
    run "ln -s #{shared_path}/rails #{release_path}/vendor/rails"  
  end  
  desc "Pack assets with rucksack" 
  task :pack_assets, :roles => [:web,:app] do 
    run "cd #{release_path} && rake RAILS_ENV=#{fetch(:rails_env, 'production')} rucksack:pack" 
  end 
  task :fix_script_perms do
    run "chmod 755 #{latest_release}/script/spin"
  end
  namespace :passenger do
    desc "Restart Application"
    task :restart do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
  after "deploy", "deploy:passenger:restart"
  after "deploy", "deploy:cleanup"
  after "deploy:update_code", "deploy:vendor_rails"  
  after "deploy:update_code", "deploy:pack_assets"
  after "deploy:update_code", "deploy:fix_script_perms"
end

task :update do
  transaction do
    update_code
    before_symlink
    symlink
  end
end

task :setup, :roles => [:app, :db, :web] do
  run <<-CMD
    mkdir -p -m 777 #{shared_path}/log
  CMD
end