growthforecast Cookbook
==============
Recipe for install growthforecast to CentOS  
Vagrant環境のCentOSへnginxをインストールし、growthforecastによるアクセス解析を行う。

PreRequirement
-----
$ vagrant box add base64 CentOS-6.3-x86_64-v20130101.box

Usage
-----
#### growthforecast::default
TODO: Write usage instructions for each cookbook.

```vm.box
   cfg.vm.box = "base64"
```

```json
{
  "nginx":{
    "port":80,
    "OS":"centos",
    "OSRELEASE":"6"
  },
  "user":{
    "name":"vagrant",
    "home":"/home/vagrant"
  },
  "perl":{
    "version":"5.17.8"
  },
  "run_list":[
    "recipe[growthforecast::default]",
    "recipe[growthforecast::nginx]",
    "recipe[growthforecast::td-agent]",
    "recipe[growthforecast::perlbrew]",
    "recipe[growthforecast::cpanm]",
    "recipe[growthforecast::growthforecast]",
    "recipe[growthforecast::supervisor]"
  ]
}
```

License and Authors
-------------------
Authors: Hiroharu Tanaka
