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

ActiveRecord::Schema.define(version: 2018_12_13_113003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stripe_token"
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "lawyer_id"
    t.integer "duration"
    t.integer "lawyer_amount_cents", default: 0, null: false
    t.string "lawyer_amount_currency", default: "USD", null: false
    t.jsonb "lawyer_payment"
    t.integer "client_amount_cents", default: 0, null: false
    t.string "client_amount_currency", default: "USD", null: false
    t.jsonb "client_payment"
    t.string "appointment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.string "payment_status", default: "pending"
    t.datetime "appointment_time"
    t.string "video_room"
    t.datetime "client_arrival_time"
    t.datetime "lawyer_arrival_time"
    t.index ["client_id"], name: "index_consultations_on_client_id"
    t.index ["lawyer_id"], name: "index_consultations_on_lawyer_id"
  end

  create_table "lawyers", force: :cascade do |t|
    t.bigint "user_id"
    t.text "description"
    t.integer "years_of_experience"
    t.boolean "is_first_consultation_free"
    t.boolean "is_online"
    t.string "stripe_token"
    t.string "stripe_id"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hourly_rate_cents", default: 0, null: false
    t.string "hourly_rate_currency", default: "USD", null: false
    t.index ["user_id"], name: "index_lawyers_on_user_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.bigint "lawyer_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_specialties_on_category_id"
    t.index ["lawyer_id"], name: "index_specialties_on_lawyer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "users"
  add_foreign_key "consultations", "clients"
  add_foreign_key "consultations", "lawyers"
  add_foreign_key "lawyers", "users"
  add_foreign_key "specialties", "categories"
  add_foreign_key "specialties", "lawyers"
end
