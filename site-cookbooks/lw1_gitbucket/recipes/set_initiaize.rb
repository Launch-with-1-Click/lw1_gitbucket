%w[/etc/pki/tls/certs/amimoto.default.crt /etc/pki/tls/private/amimoto.default.key].each do |pem|
  file pem do
    action :delete
  end
end


directory '/opt/lw1/templates' do
  action :create
  recursive true
end

cookbook_file '/opt/lw1/templates/1_0.sql.erb' do
  action :create
  source '1_0.sql.erb'
end

cookbook_file '/opt/lw1/templates/hosts.erb' do
  action :create
  source 'hosts.erb'
end

template '/opt/lw1/initial.rb' do
  action :create
  source 'initial.rb.erb'
end

cookbook_file '/etc/cron.d/first_boot' do
  action :create
  source 'first_boot'
end

