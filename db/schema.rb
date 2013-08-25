# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130818104350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter"
    t.string   "slug"
    t.string   "email"
  end

  add_index "cities", ["slug"], name: "index_cities_on_slug", using: :btree

  create_table "coaches", force: true do |t|
    t.string   "name"
    t.string   "twitter"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
  end

  create_table "coachings", force: true do |t|
    t.integer  "coach_id"
    t.string   "coachable_type"
    t.integer  "coachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "organiser"
  end

  add_index "coachings", ["coach_id"], name: "index_coachings_on_coach_id", using: :btree

  create_table "event_coachings", force: true do |t|
    t.integer "event_id", null: false
    t.integer "coach_id", null: false
  end

  add_index "event_coachings", ["event_id", "coach_id"], name: "index_event_coachings_on_event_id_and_coach_id", unique: true, using: :btree

  create_table "event_sponsorships", force: true do |t|
    t.integer "event_id",                   null: false
    t.integer "sponsor_id",                 null: false
    t.boolean "host",       default: false, null: false
  end

  add_index "event_sponsorships", ["event_id", "sponsor_id"], name: "index_event_sponsorships_on_event_id_and_sponsor_id", unique: true, using: :btree
  add_index "event_sponsorships", ["host"], name: "index_event_sponsorships_on_host", using: :btree

  create_table "events", force: true do |t|
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
  end

  create_table "invitations", force: true do |t|
    t.integer  "member_id"
    t.string   "invitable_type"
    t.boolean  "attending"
    t.integer  "invitable_id"
    t.boolean  "waiting_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "invitations", ["member_id"], name: "index_invitations_on_member_id", using: :btree

  create_table "meeting_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.datetime "date"
    t.boolean  "announced"
    t.integer  "city_id"
    t.integer  "meeting_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "coachable"
    t.integer  "available_slots"
  end

  add_index "meetings", ["city_id"], name: "index_meetings_on_city_id", using: :btree
  add_index "meetings", ["meeting_type_id"], name: "index_meetings_on_meeting_type_id", using: :btree

  create_table "members", force: true do |t|
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
  end

  add_index "members", ["city_id"], name: "index_members_on_city_id", using: :btree

  create_table "registrations", force: true do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "email",                                  null: false
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
    t.boolean  "attending",              default: false, null: false
    t.integer  "member_id"
  end

  add_index "registrations", ["email"], name: "index_registrations_on_email", using: :btree
  add_index "registrations", ["last_name"], name: "index_registrations_on_last_name", using: :btree

  create_table "sponsors", force: true do |t|
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

  create_table "sponsorships", force: true do |t|
    t.integer  "sponsor_id"
    t.string   "sponsorable_type"
    t.integer  "sponsorable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "host",             default: false, null: false
  end

  add_index "sponsorships", ["sponsor_id"], name: "index_sponsorships_on_sponsor_id", using: :btree

  create_table "users", force: true do |t|
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
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
