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

ActiveRecord::Schema.define(version: 20181112161713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.bigint "user_id"
    t.string "longitude"
    t.string "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "key"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "avatar"
    t.string "email"
    t.string "encrypted_password"
    t.integer "phone_number"
    t.text "description"
    t.string "certificate"
    t.boolean "is_doctor"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.boolean "need_admin_approval", default: false
  end

  create_table "visits", force: :cascade do |t|
    t.integer "patient_id"
    t.integer "doctor_id"
    t.string "status"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_visits_on_doctor_id"
    t.index ["patient_id"], name: "index_visits_on_patient_id"
  end

  add_foreign_key "locations", "users"
  add_foreign_key "sessions", "users"
end
