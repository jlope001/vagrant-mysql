# Dockerfile Vagrant MySQL Server 5.6
Setup your own mysql server 5.6 image with CentOS 6.

## MySQL Server
Setup your own MySQL server with a few configurable options.

## Vagrant + Docker
I use [vagrant](http://www.vagrantup.com/) and I love it.  Vagrant allows you create development environments via virtual machines.  Vagrant makes use of Docker by building the machines with Docker.  Docker does not create a VM but a light weight linux container.

Read more about Docker [here](https://www.docker.com/), its amazing.

## Setup
### Requirements
You will need docker and vagrant installed on your system.

### Environment Variables
Instead of storing sensitive information in this public repository, I make use of environment variables that you pass in.

### Build the container
Creating the container is a simple as sourcing the defaults file and running vagrant up.

```
$ source defaults.env; vagrant up
```

You should see something built out:

```
$ source defaults.env; vagrant up
Bringing machine 'mysql' up with 'docker' provider...
==> mysql: Building the container from a Dockerfile...
    mysql: Image: 34fa1200dfb8
==> mysql: Creating the container...
    mysql:   Name: mysql
    mysql:  Image: 34fa1200dfb8
    mysql: Volume: /home/USER/workspace/vagrant-mysql:/vagrant
    mysql:
    mysql: Container created: c83c839bc018ae2d
==> mysql: Starting container...
==> mysql: Provisioners will not be run since container doesn't support SSH.
```

Once completed, you can link this container to other docker containers by name of 'mysql'. Or expose port 3306 and connect to the container directly by obtaining the IP via docker inspect.
