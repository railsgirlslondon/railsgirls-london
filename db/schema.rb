# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170219183339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter"
    t.string   "slug"
    t.string   "email"
    t.string   "coaches_mailing_list"
    t.string   "twitter_widget_id"
    t.index ["slug"], name: "index_cities_on_slug", using: :btree
  end

  create_table "coaches", force: :cascade do |t|
    t.string   "name"
    t.string   "twitter"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
  end

  create_table "coachings", force: :cascade do |t|
    t.integer  "coach_id"
    t.string   "coachable_type"
    t.integer  "coachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "organiser"
    t.integer  "attended"
    t.text     "attendance_note"
    t.index ["coach_id"], name: "index_coachings_on_coach_id", using: :btree
  end

  create_table "event_coachings", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "coach_id", null: false
    t.index ["event_id", "coach_id"], name: "index_event_coachings_on_event_id_and_coach_id", unique: true, using: :btree
  end

  create_table "event_sponsorships", force: :cascade do |t|
    t.integer "event_id",                   null: false
    t.integer "sponsor_id",                 null: false
    t.boolean "host",       default: false, null: false
    t.index ["event_id", "sponsor_id"], name: "index_event_sponsorships_on_event_id_and_sponsor_id", unique: true, using: :btree
    t.index ["host"], name: "index_event_sponsorships_on_host", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.text     "description"
    t.integer  "city_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "starts_on"
    t.date     "ends_on"
    t.date     "registration_deadline"
    t.string   "title"
    t.boolean  "coachable"
    t.string   "image"
    t.integer  "available_slots"
    t.boolean  "accepting_feedback",    default: false, null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "application_url"
    t.string   "application_description"
    t.string   "github_url"
    t.string   "feelings_before"
    t.string   "feelings_after"
    t.string   "comments"
    t.integer  "invitation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "permission"
    t.integer  "rating"
    t.string   "email_address"
    t.integer  "event_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "invitee_id"
    t.string   "invitable_type"
    t.boolean  "attending"
    t.integer  "invitable_id"
    t.boolean  "waiting_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "invitee_type"
    t.text     "comment"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id", using: :btree
  end

  create_table "meeting_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "date"
    t.boolean  "announced"
    t.integer  "city_id"
    t.integer  "meeting_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "coachable"
    t.integer  "available_slots"
    t.index ["city_id"], name: "index_meetings_on_city_id", using: :btree
    t.index ["meeting_type_id"], name: "index_meetings_on_meeting_type_id", using: :btree
  end

  create_table "meetups", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starts_on"
    t.integer  "available_slots"
    t.string   "image"
    t.string   "address"
    t.string   "postcode"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "location_website"
    t.string   "location_name"
    t.string   "short_blurb"
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "twitter"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
    t.boolean  "active",       default: true
    t.index ["city_id"], name: "index_members_on_city_id", using: :btree
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "first_name",                                null: false
    t.string   "last_name",                                 null: false
    t.string   "email",                                     null: false
    t.string   "twitter"
    t.string   "gender"
    t.string   "phone_number"
    t.text     "programming_experience"
    t.text     "reason_for_applying"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uk_resident"
    t.string   "os"
    t.string   "os_version"
    t.string   "spoken_languages"
    t.string   "preferred_language"
    t.string   "address"
    t.integer  "event_id"
    t.string   "dietary_restrictions"
    t.string   "selection_state"
    t.boolean  "attending",                 default: false, null: false
    t.integer  "member_id"
    t.text     "how_did_you_hear_about_us"
    t.integer  "attended"
    t.text     "attendance_note"
    t.index ["email"], name: "index_registrations_on_email", using: :btree
    t.index ["last_name"], name: "index_registrations_on_last_name", using: :btree
  end

  create_table "social_media", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["city_id"], name: "index_social_media_on_city_id", using: :btree
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name"
    t.string "primary_contact_email"
    t.text   "description"
    t.string "image_url"
    t.string "website"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "address_city"
    t.string "address_postcode"
  end

  create_table "sponsorships", force: :cascade do |t|
    t.integer  "sponsor_id"
    t.string   "sponsorable_type"
    t.integer  "sponsorable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "host",             default: false, null: false
    t.index ["sponsor_id"], name: "index_sponsorships_on_sponsor_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
