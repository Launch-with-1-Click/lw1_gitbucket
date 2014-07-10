template '/etc/nginx/nginx.conf' do
  action :create
  source 'nginx.conf.erb'
end
