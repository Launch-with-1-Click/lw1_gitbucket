package "php56-fpm"

directory "/opt/lw1/www/" do
  owner 'apache'
  group 'apache'
  mode  '0755'
end

cookbook_file "/opt/lw1/tasks/install_amiage.php.erb" do
  source "lw1_tasks/install_amiage.php.erb"
end

