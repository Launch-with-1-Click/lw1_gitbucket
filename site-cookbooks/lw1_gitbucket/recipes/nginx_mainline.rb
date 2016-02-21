template "/etc/yum.repos.d/amimoto-nginx-mainline.repo" do
  source "yum/amimoto-nginx-mainline.repo.erb"
  owner "root"
  group "root"
  mode  "0644"
end
