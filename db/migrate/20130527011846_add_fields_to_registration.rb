class AddFieldsToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :uk_resident, :string
    add_column :registrations, :os, :string
    add_column :registrations, :os_version, :string
    add_column :registrations, :spoken_languages, :string
    add_column :registrations, :preferred_language, :string
    add_column :registrations, :address, :string
  end
end
