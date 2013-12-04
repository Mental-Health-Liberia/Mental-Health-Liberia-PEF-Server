# Deployment
Deploying the PEF server is like deploying any Rails app with some small differences.

The instructions below are for deploying PEF using [Phusion Passenger](https://www.phusionpassenger.com). It assumes a fresh [Ubuntu 12.04 Server](http://www.ubuntu.com/download/server) install with LAMP setup (option in the installation).

Some instructions are copied straight from users guides for the respective technologies; if in doubt, reference them for exact or updated instructions.

## Install Phusion Passenger
These instructions are taken from the [Phusion Passenger Users Guide](http://www.modrails.com/documentation/Users%20guide%20Apache.html#install_on_debian_ubuntu).

This installs the open source version of Passenger.

```
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
$ sudo apt-get install apt-transport-https
```

Create `/etc/apt/sources.list.d/passenger.list` and insert `deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main`.

```
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update
sudo apt-get install libapache2-mod-passenger
```

## Install MongoDB
These instructions are taken from MongoDB's [guide for installing on Ubuntu](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/).

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
```

Create `/etc/apt/sources.list.d/mongodb.list` and insert `deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen`.

```
sudo chown root: /etc/apt/sources.list.d/mongodb.list
sudo chmod 600 /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-10gen
```

## Install Ruby
These instructions are taken from RVM's [homepage](https://rvm.io).

```
\curl -L https://get.rvm.io | bash -s stable
```

## Install Git and Node.JS
NodeJS is a javascript executable environment required for Rails to run.

```
sudo apt-get install git nodejs
```

Note: Some repositories hold an old version of node (0.6.x). To get an updated version read the [instructions from Node.JS](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#ubuntu-mint-elementary-os).

## Get PEF Server
```
sudo mkdir /webapps
sudo chown user: /webapps
cd /webapps
git clone https://github.com/Mental-Health-Liberia/Mental-Health-Liberia-PEF-Server.git
```

Now we have to ensure that all gems are installed for the server to run (including Rails).

```
cd Mental-Health-Liberia-PEF-Server
bundle
```

At this point, we should be able to run `rails server` and have the server successfully start up and be accessible locally.

## Apache Configuration
These instructions are taken from the [Phusion Passenger Users Guide](http://www.modrails.com/documentation/Users%20guide%20Apache.html#_deploying_a_rack_based_ruby_application_including_rails_gt_3).

Add the following to your Apache configuration file (e.g. in `/etc/apache2/sites-enabled/`):
```
PassengerRuby PATH_TO_RUBY

<VirtualHost *:80>
    ServerName www.example.com
    DocumentRoot /webapps/Mental-Health-Liberia-PEF-Server/public
    <Directory /webapps/Mental-Health-Liberia-PEF-Server/public>
        Allow from all
        Options -MultiViews
    </Directory>
</VirtualHost>
```

`PATH_TO_RUBY` is the result of the `which ruby`, i.e. the version of Ruby we would like Passenger to use to run this app.

After doing so, restart apache:
```
sudo apachectl restart
```

## Installing the Web Frontend
This does not have to be done on the server, it can be done on your local computer.

Essentially, what will happen here is you will "build" a copy of the frontend and move that to the PEF Ruby on Rails app.

### Get the Frontend
```
git clone https://github.com/Mental-Health-Liberia/Mental-Health-Liberia-PEF-Client.git
```

### Build the Frontend
These instructions are taken from the [PEF Fronend's README](https://github.com/Mental-Health-Liberia/Mental-Health-Liberia-PEF-Client/blob/master/README.md#how-to-run).

First get the dependencies:
```
npm install
bower install
bundle
```

And then build!
```
grunt build
```

### Copy `dist` to Server App
Move the contents of the `dist` directory to the server app's `public` directory.

## Done
At this point, the server should be running and accessible via the `www.example.com`.

