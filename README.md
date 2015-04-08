<h1>
    Ansible Vagrant VM
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="url"><img src="http://upload.wikimedia.org/wikipedia/commons/8/87/Vagrant.png" height="48"></a>
    &nbsp;
    <a href="url"><img src="http://cdn2.hubspot.net/hub/330046/file-764918166-png/Official_Logos/ansible_circleA_black_small.png?t=1425489360760" height="48"></a>
</h1>
>This Vagrant is built with [Ansible](http://www.ansible.com/home).

This box contains the following:
* HHVM
* PHP-FPM that can be 5.4, 5.5 or 5.6 with:
    - php5-imagick
    - php5-curl
    - php5-gd
    - php5-memcached
    - php5-mysql
    - php5-pgsql
    - php5-xdebug
    - phpunit
    - php-pear
    - php5-mcrypt
    - php5-intl
    - php5-mongo
    - php5-redis
* Nginx with SSL support
* Apache
* MySQL
* Composer
* Memcached
* Node.js
* Ruby

Prerequisites
-------------
* Install [Vagrant](http://docs.vagrantup.com/v2/installation/index.html) on your system, which in turn requires [RubyGems](https://rubygems.org/pages/download) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

*NOTE: If you are on Windows, I would recommend [RubyInstaller](http://rubyinstaller.org/) for installing Ruby and any ssh client as [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) for log into your Vagrant box.*

* For simplified the usage of this box, you should install **[vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)** plugin for Vagrant, which adds an entry to your `/etc/hosts` file on the host system and **[vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)** plugin which automatically installs the host's VirtualBox Guest Additions on the guest system.
```
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-vbguest
```
    

Getting started
---------------

Firstly, you have to duplicate the `parameters.yml.dist` in the same directory but without `.dist`
extension, modifying the values with your favorite preferences. The following configuration is by default:

```
#### REQUIRED ####
vm:
  host_name:     app
  domain:        localhost
  host_path:     /var/www
  public_dir:    /web
  ip:            192.168.10.44
  port:          8080
  synced_folder: nfs                                        # can be nfs, smb or rsync
  box:           http://files.vagrantup.com/precise64.box
  cpu:           1
  memory:        512

#### OPTIONAL ####
nginx: ~
apache:
  version: 2.2                                              # can be 2.2 or 2.4
php:
  switcher: hhvm                                            # can be php or hhvm
  version:  5.6                                             # can be 5.4, 5.5 or 5.6
  timezone: UTC
  pecl:
    - mongo
    - redis
  xdebug:
    version:           2.2.5
    max_nesting_level: 256
    ide_key:           sublime.xdebug
    remote:
      host:            localhost
      port:            9001
mysql:
  version:       5.6                                        # can be 5.5, 5.6 or 5.7
  root_password: root
  user:          user
  password:      123
  database:      defaultDB
memcached: ~
nodejs:
  version: 0.12.22
  packages:
    - gulp
    - bower
    - nodemon
    - debug
    - foreman
ruby:
  version: 1.9.3
  gems:
    - sass
    - compass
    - scss-lint
```

Then, you have to build the *Vagrant* machine and then, you have to connect via **ssh** to the VM with the following commands:

    vagrant up
    vagran ssh

That's all! Now you can type your hostname in your favorite browser as this:

    app.localhost

    
Credits
-------
Inspirated by Zach Adams's [hgv-deploy-full](https://github.com/zach-adams/hgv-deploy-full) and [Phansible](http://phansible.com/).

Created by **benatespina** - [benatespina@gmail.com](mailto:benatespina@gmail.com).
Copyright (c) 2015

[![License](http://img.shields.io/:license-mit-yellowgreen.svg)](https://github.com/benatespina/ansible-vagrant/blob/master/LICENSE)
