# SITEMAP
Backend of Sitemap project. Use [ancestry](https://github.com/stefankroes/ancestry/) gem to organize tree structure of sitemap. Represent SiteLink model with serializer, controller and CreateSiteLink service.

## Install

### Clone the repository

```shell
git clone git@github.com:mmiseyko/sitemap.git
cd sitemap
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.7.0`

If not, install the right ruby version using [rvm](https://rvm.io/) (it could take a while):

```shell
rvm install ruby 2.7.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```

### Pre-commit hooks setup

```ruby
gem install overcommit
overcommit --install
```

## Run tests

```shell
rspec
```

## Run rubocop

```shell
rubocop
```
