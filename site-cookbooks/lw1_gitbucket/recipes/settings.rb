cookbook_file '/etc/default/gitbucket' do
  action :create
  source 'gitbucket_default'
  mode '0600'
  owner 'root'
  group 'root'
end
