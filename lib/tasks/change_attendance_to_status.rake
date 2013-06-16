namespace :data_migration do
  task :selection_states => :environment do
    require_relative './selection_state_data_migrator'
    puts "Migrating registrations"
    SelectionStateDataMigrator.migrate!
    puts "Done! Delete this data migration."
  end
end

