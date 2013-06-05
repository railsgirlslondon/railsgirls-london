test:
	bundle exec rspec
migrate:
	bundle exec rake db:migrate db:test:prepare
wipe:
	bundle exec rake db:drop db:create db:migrate db:test:prepare
backup_production:
	heroku pgbackups:capture --app=railsgirlslondon
	curl -o pg-production-latest.dump `heroku pgbackups:url --app=railsgirlslondon`
	bzip2 pg-production-latest.dump
deploy_production:
	heroku maintenance:on --app=railsgirlslondon
	git tag production_release_`date +"%Y%m%d-%H%M%S"`
	git push production production:master
	heroku run rake db:migrate --app=railsgirlslondon
	heroku maintenance:off --app=railsgirlslondon
