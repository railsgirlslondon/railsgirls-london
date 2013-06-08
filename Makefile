test:
	bundle exec rspec
migrate:
	bundle exec rake db:migrate db:test:prepare
wipe:
	bundle exec rake db:drop db:create db:migrate db:test:prepare
db_staging:
	heroku pg:psql --app=railsgirlslondon-staging
db_production:
	heroku pg:psql --app=railsgirlslondon
open_staging:
	heroku open --app=railsgirlslondon-staging
open_production:
	heroku open --app=railsgirlslondon
backup_production:
	heroku pgbackups:capture --app=railsgirlslondon
	curl -o pg-production-latest.dump `heroku pgbackups:url --app=railsgirlslondon`
	bzip2 pg-production-latest.dump
deploy_production:
	heroku maintenance:on --app=railsgirlslondon
	git tag production_release_`date +"%Y%m%d-%H%M%S"`
	git push --tags
	git push production production:master
	heroku run rake db:migrate --app=railsgirlslondon
	heroku maintenance:off --app=railsgirlslondon
backup_staging:
	heroku pgbackups:capture --app=railsgirlslondon-staging
	curl -o pg-staging-latest.dump `heroku pgbackups:url --app=railsgirlslondon-staging`
	bzip2 pg-staging-latest.dump
deploy_staging:
	heroku maintenance:on --app=railsgirlslondon-staging
	git tag staging_release_`date +"%Y%m%d-%H%M%S"`
	git push --tags
	git push staging staging:master
	heroku run rake db:migrate --app=railsgirlslondon-staging
	heroku maintenance:off --app=railsgirlslondon-staging
copy_production_db_to_staging:
	heroku pgbackups:restore HEROKU_POSTGRESQL_IVORY_URL \
		--app=railsgirlslondon-staging \
		`heroku pgbackups:url --app=railsgirlslondon`
