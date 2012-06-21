# Zorros-deploy gem

[![Build Status](https://secure.travis-ci.org/Zorros/zorros-deploy.png?branch=master)](http://travis-ci.org/Zorros/zorros-deploy)

That's only a sample gem done to show the Zorros people how to create a small
gem.

It's only purpose is to add a tag to the git repository of a project each time
it's deployed with capistrano. It heavily follows our way of working so it will
probably **not fit for you**. But if it does, please, feel free to give us a
hand with it!

## How to use it

The gem supposes you've a multistage environment set up. You'll need to include
it on your `config/deploy/production.rb` file, like that.

```ruby
require 'zorros-deploy/capistrano'
```

Once you've done it, you'll have a small task on capistrano wich will
automatically create a git tag with the format `dd-mm-yyyy` each time you
deploy to production.

The tag will be created in your working copy's current branch, so make sure
you're in the branch/commit you're deploying to tag the right thing.
