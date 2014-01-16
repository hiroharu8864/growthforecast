#
# Cookbook Name:: nginx
# Recipe:: td-agent
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#td-agent
package "td-agent" do
  action :upgrade
end

#install of fluent-plugin-growthforecast
%w{growthforecast datacounter}.each do |plugin|
  gem_package "fluent-plugin-#{plugin}" do
    gem_binary "/usr/lib64/fluent/ruby/bin/fluent-gem"
    action :install
  end
end

git "/etc/td-agent/plugin/fluent-plugin-tail-labeled-tsv" do
  repository "git://github.com/stanaka/fluent-plugin-tail-labeled-tsv.git"
  # reference "master"
  action :checkout
end

link "/etc/td-agent/plugin/in_tail_labeled_tsv.rb" do
  to "/etc/td-agent/plugin/fluent-plugin-tail-labeled-tsv/lib/fluent/plugin/in_tail_labeled_tsv.rb"
end

service "td-agent" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

template "td-agent.conf" do
  path "/etc/td-agent/td-agent.conf"
  source "td-agent.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[td-agent]'
end

bash "td-agent-log-create" do
  code <<-EOC
    touch /var/log/nginx/access.log
  EOC

  not_if { File.exists?("/var/log/nginx/access.log") }
end

bash "td-agent-log-auth" do
  code <<-EOC
    chmod 644 /var/log/nginx/access.log
  EOC

  only_if { File.exists?("/var/log/nginx/access.log") }  
end
