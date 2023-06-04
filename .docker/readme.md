## Docker

This directory is only meant to be used for development, and contains some
necessary setup to spin up docker containers with multiple ruby environment.

### Setup

Before doing anything, you might want to create a symlink to the docker file and
Makefile. This would allow you to avoid some of the unnecessary work related to
the file paths To do that run the following from the root of the project.

```
ln -sf .docker/Makefile .
ln -sf .docker/docker-compose.yml .
```

By default it usages the most recent ruby version for docker environment, but if
you want to run it in any specific version then you can set it up by exporting
`RUBY_IMAGE` environment variable in your shell:

```sh
export RUBY_IMAGE=ruby:3.0-buster
```

Once everything is set then you would need to build the development images for
the first time and you can do that using:

```sh
make setup
```

The setup process will install all dependencies and it will also setup a volume
to speed up the repeated gem installation.

### Playground

The `Makefile` contains two target for tests, and you can run the tests using
any of the following commands:

```sh
make test

# or
make rspec
```

If you need more control, and you want to do some development on the go then you
can get into the container using:

```sh
make ssh
```

### Cleanup

Once you are done with your experiment then you can cleanup the docker
environment using the following command.

```sh
make down
```
