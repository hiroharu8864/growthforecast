#
# Cookbook Name:: nginx
# Recipe:: growthforecast
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#dependence of growthforecast
%w{cairo cairo-devel pango pango-devel libxml2-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

#bitmap-console-fonts
package 'bitmap-console-fonts' do
  action :install
  only_if { node['platform'] == 'centos' }
end

#growthforecast
bash "growthforecast" do
  path = node['user']['home'] + "/perl5/perlbrew/perls/perl-" + node['perl']['version'] + "/bin"
  environment "PATH_CPANM" => path

  code <<-EOC
    $PATH_CPANM/cpanm -n 'GrowthForecast'
  EOC
end

directory node['user']['home'] + "/growthforecast/" do
  owner node['user']['name']
  group node['user']['group']
  mode 0755
  action :create
end

template "growthforecast.run" do
  path node['user']['home'] + "/growthforecast/growthforecast.run"
  source "growthforecast.run.erb"
  owner node['user']['name']
  group node['user']['group']
  mode 0755
end
