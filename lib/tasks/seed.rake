namespace :db do
  desc 'Import production seed data'
  task import_from_production: :environment do
    seeder = RailsGirls::Seeder.new
    seeder.import
  end
end
