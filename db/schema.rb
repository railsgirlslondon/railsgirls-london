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

ActiveRecord::Schema.define(version: 20130530194451) do

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "twitter"
    t.string   "slug"
  end

  add_index "cities", ["slug"], name: "index_cities_on_slug"

  create_table "coaches", force: true do |t|
    t.string   "name"
    t.string   "twitter"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_sponsorships", force: true do |t|
    t.integer "event_id",   null: false
    t.integer "sponsor_id", null: false
  end

  add_index "event_sponsorships", ["event_id", "sponsor_id"], name: "index_event_sponsorships_on_event_id_and_sponsor_id", unique: true

  create_table "events", force: true do |t|
    t.text     "description"
    t.integer  "city_id"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "starts_on"
    t.date     "ends_on"
  end

  create_table "registrations", force: true do |t|
    t.string   "first_name",             null: false
    t.string   "last_name",              null: false
    t.string   "email",                  null: false
    t.string   "twitter"
    t.string   "gender"
    t.string   "phone_number"
    t.text     "programming_experience"
    t.text     "reason_for_applying"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "uk_resident"
    t.string   "os"
    t.string   "os_version"
    t.string   "spoken_languages"
    t.string   "preferred_language"
    t.string   "address"
    t.integer  "event_id"
    t.string   "dietary_restrictions"
  end

  add_index "registrations", ["email"], name: "index_registrations_on_email"
  add_index "registrations", ["last_name"], name: "index_registrations_on_last_name"

  create_table "sponsors", force: true do |t|
    t.string "name"
    t.string "primary_contact_email"
    t.text   "description"
  end

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
