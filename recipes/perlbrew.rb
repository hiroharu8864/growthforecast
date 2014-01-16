#
# Cookbook Name:: nginx
# Recipe:: perlbrew
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#perlbrew
bash "perlbrew" do
  user node['user']['name']
  cwd node['user']['home']
  environment "HOME" => node['user']['home']

  code <<-EOC
    curl -kL http://install.perlbrew.pl | bash
  EOC

  not_if { File.exists?(node['user']['home'] + "/perl5/perlbrew/bin/perlbrew") }
end
