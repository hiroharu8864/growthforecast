#
# Cookbook Name:: nginx
# Recipe:: perlbrew
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#perl and cpanm
bash "perl" do
  home = node['user']['home']
  path = home + "/perl5/perlbrew/perls/perl-" + node['perl']['version'] + "/bin/perl"
  user node['user']['name']
  cwd home
  environment "HOME" => home

  code <<-EOC
    source ~/perl5/perlbrew/etc/bashrc
    perlbrew install --notest #{node['perl']['version']}
    perlbrew switch #{node['perl']['version']}
    curl -L http://cpanmin.us | perl - App::cpanminus
  EOC

  not_if { File.exists?(path) }
end
