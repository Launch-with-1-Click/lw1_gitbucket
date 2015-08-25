group 'jetty' do
  action :create
  gid 1000
end

user 'jetty' do
  action :create
  home '/opt/gitbucket'
  shell '/bin/false'
  system true
  uid 1000
  gid 1000
end

execute "chown jetty.jetty -R /opt/gitbucket/jetty" do
  action :nothing
  subscribes :run, "user[jetty]"
end

