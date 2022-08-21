# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_21_085335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "twitter", limit: 255
    t.string "slug", limit: 255
    t.string "email", limit: 255
    t.string "coaches_mailing_list", limit: 255
    t.string "twitter_widget_id", limit: 255
    t.index ["slug"], name: "index_cities_on_slug"
  end

  create_table "coaches", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "twitter", limit: 255
    t.string "email", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "phone_number", limit: 255
  end

  create_table "coachings", id: :serial, force: :cascade do |t|
    t.integer "coach_id"
    t.string "coachable_type", limit: 255
    t.integer "coachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "organiser"
    t.integer "attended"
    t.text "attendance_note"
    t.index ["coach_id"], name: "index_coachings_on_coach_id"
  end

  create_table "event_coachings", id: :serial, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "coach_id", null: false
    t.index ["event_id", "coach_id"], name: "index_event_coachings_on_event_id_and_coach_id", unique: true
  end

  create_table "event_sponsorships", id: :serial, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "sponsor_id", null: false
    t.boolean "host", default: false, null: false
    t.index ["event_id", "sponsor_id"], name: "index_event_sponsorships_on_event_id_and_sponsor_id", unique: true
    t.index ["host"], name: "index_event_sponsorships_on_host"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.text "description"
    t.integer "city_id"
    t.boolean "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "starts_on"
    t.date "ends_on"
    t.date "registration_deadline"
    t.string "title", limit: 255
    t.boolean "coachable"
    t.string "image", limit: 255
    t.integer "available_slots"
    t.boolean "accepting_feedback", default: false, null: false
    t.date "registration_deadline_early_bird"
  end

  create_table "feedbacks", id: :serial, force: :cascade do |t|
    t.string "application_url", limit: 255
    t.string "application_description", limit: 255
    t.string "github_url", limit: 255
    t.text "feelings_before"
    t.string "feelings_after", limit: 255
    t.text "comments"
    t.integer "invitation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "permission"
    t.integer "rating"
    t.string "email_address"
    t.integer "event_id"
  end

  create_table "invitations", id: :serial, force: :cascade do |t|
    t.integer "invitee_id"
    t.string "invitable_type", limit: 255
    t.boolean "attending"
    t.integer "invitable_id"
    t.boolean "waiting_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "token", limit: 255
    t.string "invitee_type", limit: 255
    t.text "comment"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
  end

  create_table "meeting_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.string "frequency", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", id: :serial, force: :cascade do |t|
    t.datetime "date"
    t.boolean "announced"
    t.integer "city_id"
    t.integer "meeting_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "coachable"
    t.integer "available_slots"
    t.index ["city_id"], name: "index_meetings_on_city_id"
    t.index ["meeting_type_id"], name: "index_meetings_on_meeting_type_id"
  end

  create_table "meetups", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "starts_on"
    t.integer "available_slots"
    t.string "image"
    t.string "address"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location_website"
    t.string "location_name"
    t.string "short_blurb"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "phone_number", limit: 255
    t.string "email", limit: 255
    t.string "twitter", limit: 255
    t.integer "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uuid", limit: 255
    t.boolean "active", default: true
    t.index ["city_id"], name: "index_members_on_city_id"
  end

  create_table "registrations", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "twitter", limit: 255
    t.string "gender", limit: 255
    t.string "phone_number", limit: 255
    t.text "programming_experience"
    t.text "reason_for_applying"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uk_resident", limit: 255
    t.string "os", limit: 255
    t.string "os_version", limit: 255
    t.string "spoken_languages", limit: 255
    t.string "preferred_language", limit: 255
    t.string "address", limit: 255
    t.integer "event_id"
    t.string "dietary_restrictions", limit: 255
    t.string "selection_state", limit: 255
    t.boolean "attending", default: false, null: false
    t.integer "member_id"
    t.text "how_did_you_hear_about_us"
    t.integer "attended"
    t.text "attendance_note"
    t.index ["email"], name: "index_registrations_on_email"
    t.index ["last_name"], name: "index_registrations_on_last_name"
  end

  create_table "social_media", id: :serial, force: :cascade do |t|
    t.integer "city_id"
    t.string "name", limit: 255
    t.string "url", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["city_id"], name: "index_social_media_on_city_id"
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "primary_contact_email", limit: 255
    t.text "description"
    t.string "image_url", limit: 255
    t.string "website", limit: 255
    t.string "address_line_1", limit: 255
    t.string "address_line_2", limit: 255
    t.string "address_city", limit: 255
    t.string "address_postcode", limit: 255
  end

  create_table "sponsorships", id: :serial, force: :cascade do |t|
    t.integer "sponsor_id"
    t.string "sponsorable_type", limit: 255
    t.integer "sponsorable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "host", default: false, null: false
    t.index ["sponsor_id"], name: "index_sponsorships_on_sponsor_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
