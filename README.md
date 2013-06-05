[![Code Climate](https://codeclimate.com/github/railsgirlslondon/railsgirls-london.png)](https://codeclimate.com/github/railsgirlslondon/railsgirls-london) [![Build Status](https://travis-ci.org/railsgirlslondon/railsgirls-london.png?branch=master)](https://travis-ci.org/railsgirlslondon/railsgirls-london) [![Coverage Status](https://coveralls.io/repos/railsgirlslondon/railsgirls-london/badge.png?branch=master)](https://coveralls.io/r/railsgirlslondon/railsgirls-london?branch=master)

# Rails Girls London

This is the website and asset repository for the Rails Girls London website. 

This app helps us run our local organisation.

![Rails Girls London logo](https://raw.github.com/allolex/railsgirls-london/master/public/images/rails_girls_london_logo_ruby.png "Rails Girls London")


## On the web

- Visit our event page here: [http://railsgirls.com/london](http://railsgirls.com/london)
- Sign up to our mailing list here: [https://groups.google.com/forum/#!forum/rails-girls-london](http://bit.ly/rglondon)
- Sign up here if you are interested in coaching: [https://groups.google.com/forum/#!forum/rails-girls-london-coaches](http://bit.ly/rglcoaches)


## Social Networking

We are [@railsgirls_ldn](https://twitter.com/railsgirls_ldn) on Twitter.

Our Google+ page is here: [https://plus.google.com/b/104252944343767158344/](http://bit.ly/rgl-gplus)


## Contributing to This Site

1. Fork the repository
2. Create your own branch _git checkout -b **mybranch**_
3. Apply your changes
4. Run `rake` to verify that the tests are passing
5. Submit a pull request

Documentation should use [Github-flavoured Markdown](https://help.github.com/articles/github-flavored-markdown), but with explicit links.

We use [Kippt](https://kippt.com/) for collecting resources. The mainpage dynamically pulls in resources from kippt if it's configured. If you'd like to see the links, either sign up for kippt yourself and configure it (look at config/kippt.yml.example for reference), or ask one of the core members for the username/token information. If you don't know what this means, feel free to ask or ignore it all together!

## Deployment

Make sure you have access to the Heroku app. One of the organisers can arrange that.

    heroku git:remote -r production --app=railsgirlslondon
    heroku git:remote -r staging --app=railsgirlslondon-staging

Since we are using Heroku, the deployment is done via a git push to the appropriate remote repository. Since doing it properly involves several steps, we have a Makefile for the deployment. This means you can just use `make` to deploy:

    git co staging
    make deploy_staging

This will turn on maintenance mode for the staging app, add a tag for the release, push changes to the heroku app, run migrations and turn maintenance mode off again.

## Backups

You can create a backup with:

    make backup_production
    make backup_staging

These commands will create a local copy of the PostgreSQL databases on Heroku.
