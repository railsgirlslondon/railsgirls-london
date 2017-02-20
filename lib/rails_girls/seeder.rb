module RailsGirls
  class Seeder

    def import
      download_seed
      import_seed
      clean_local_dump
      change_data
      create_admin
    end

    def download_seed
      command = "pg_dump -Fc --no-acl --no-owner "\
        "-d #{source_database} > #{temporary_dump_filename}"

      `#{command}`
    end

    def import_seed
      raise "Don't do this on production!" if Rails.env.production?

      command = "pg_restore --verbose -c -O -h localhost"\
        " -d #{localhost_development} #{temporary_dump_filename}"

      `#{command}`
    end

    def change_data
      raise "Don't do this on production!" if Rails.env.production?

      Coach.all.each do |coach|
        coach.update_columns(
          name: Faker::Name.name,
          email: set_email("coach#{coach.id}"),
          phone_number: "11222244433",
          twitter: "like-anything-that-goes-for-this-field"
        )
      end

      Feedback.update_all(
        email_address: set_email("feedback")
      )

      Member.all.each do |member|
        member.update_columns(
          email: set_email("member#{member.id}"),
          twitter: "like-anything-that-goes-for-this-field",
          phone_number: "11222244433",
          last_name: Faker::Name.last_name,
          first_name: Faker::Name.first_name
        )
      end

      Registration.all.each do |registration|
        registration.update_columns(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: set_email("reg#{registration.id}"),
          address: Faker::Address.street_address,
          twitter: "like-anything-that-goes-for-this-field",
          phone_number: "11222244433"
        )
      end

      Sponsor.update_all(
        primary_contact_email: set_email("sponsor")
      )
    end

    def create_admin
      User.all.each do |admin|
        admin.update_columns(
          email: set_email("admin#{admin.id}")
        )
        admin.password = 'password'
        admin.save
      end

      User.create(
        email: set_email("admin"),
        password: 'password'
      )
    end

    def set_email(detail)
      "railsgirlslondon+#{detail}@railsgirlslondon.com"
    end

    def clean_local_dump
      `rm #{temporary_dump_filename}`
    end

    def temporary_dump_filename
      'public/rails_girls_data.dump'
    end

    def localhost_development
      'railsgirls_development'
    end

    def source_database
      ENV['DATA_TO_DOWNLOAD']
    end

  end
end
