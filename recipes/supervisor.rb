#
# Cookbook Name:: nginx
# Recipe:: supervisor
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#supervisor
#supervisor needs python-setuptool package
rpmfile="supervisor-3.0-13.1.noarch.rpm"

package "python-setuptools" do
  action :install
end

cookbook_file "/tmp/#{rpmfile}" do
  mode 00644
end

package "supervisor" do
  action :install
  source "/tmp/#{rpmfile}"
end

service "supervisord" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end

template "supervisord.conf" do
  path "/etc/supervisord.conf"
  source "supervisord.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies [ :restart], 'service[supervisord]'
end

