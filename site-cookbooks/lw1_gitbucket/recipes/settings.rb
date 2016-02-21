cookbook_file '/etc/default/gitbucket' do
  action :create
  source 'gitbucket_default'
  mode '0600'
  owner 'root'
  group 'root'
end

service 'sendmail' do
  action [:stop, :disable]
end

package 'postfix'

ruby_block "postfix main.cf" do
  block do
    _file = Chef::Util::FileEdit.new('/etc/postfix/main.cf')
    _file.search_file_replace_line(/^#local_recipient_maps =$/, "local_recipient_maps =")
    _file.write_file
  end
end
