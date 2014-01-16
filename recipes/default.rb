#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#Disable iptables
service "iptables" do
  action [ :disable, :stop ]
end 

#read repository
template "install.repo" do
  path "/etc/yum.repos.d/install.repo"
  source "install.repo.erb"
  owner "root"
  group "root"
  mode 0644
end

#git
%w{git}.each do |pkg|
  package pkg do
    action :install
  end
end
